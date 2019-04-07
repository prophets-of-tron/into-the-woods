extends TileGenerator

signal terrain_stack_generated(x)
signal terrain_tile_generated(x, y)	# we probably won't need to use this

export(float) var height_harshness
export(int) var min_height
export(int) var max_height
export(int) var water_level
export(int) var rel_sand_height

var heights = {}	# 1d heightmap cache

var constants
var state

func _ready():
	._ready()

	constants = get_node("/root/Constants")
	state = get_node("/root/State")

func _gen_stack(x):
	for y in range(sample_height(x)):
		# replace dirt that's exposed to air to grass after next stack's generation
		var type = layer.dirt
		layer.set_cell(x, y, type)
		# after _ready (add_child)
		emit_signal("terrain_tile_generated", x, y)

	for y in range(sample_height(x), water_level):
		layer.set_cell(x, y, layer.water)

	emit_signal("terrain_stack_generated", x)

# TODO: add this method to TileGenerator
func _post_gen_stack(x):
	# Calculate if the tile is exposed to air or not.
	# If exposed to air, replace with a grass tile.
	# (Stack should already be generated!)

	# Turn all tiles that touch a block at water level to sand
	# Turn dirt that is exposed to air to grass

	for y in range(heights[x]):
		if _is_tile_exposed_water_level(x, y):
			layer.set_cell(x, y, layer.sand)
		elif _is_tile_exposed_air(x, y):
			if layer.get_cell(x, y) == layer.dirt:
				layer.set_cell(x, y, layer.grass)

func process_stack(x):
	# generate current stack
	_gen_stack(x)

	# apply post-generation touches (dirt -> grass) to the existing neighbor
	# this works because in Map#gen_stack, this gen_stack is called
	# 	before updating left and right
	var a_stack = layer.map_manager.left != +INF and layer.map_manager.right != -INF
	if a_stack:
		var existing_neighbor_x
		if x == layer.map_manager.left - 1:
			existing_neighbor_x = x + 1
		elif x == layer.map_manager.right + 1:
			existing_neighbor_x = x - 1
		else:
			# uh-oh
			pass	# let existing_neighbor_x remain underfined
		_post_gen_stack(existing_neighbor_x)

func sample_height(x):
	# cache
	if heights.has(x):
		return heights[x]

	var nz = state.noise.get_noise_2d(height_harshness * x, 0)
	var height = floor(min_height + (max_height - min_height) * (nz + 1) / 2)
	heights[x] = height
	return height

func get_top_tile(x):
	return layer.get_cell(x, sample_height(x) - 1)

"""Local helpers"""

# Tests if tile is exposed to air (structures are ignored)
func _is_tile_exposed_air(x, y):
	var pos = Vector2(x, y)
	# check left, right, top and bottom of tile for air
	var positions = [pos + Vector2.LEFT,
		pos + Vector2.RIGHT,
		pos + Vector2.UP,
		pos + Vector2.DOWN]

	for position in positions:
		# Don't check if < height, because that's the
		# 	primary condition we're testing.
		if position.x >= layer.map_manager.left and position.x <= layer.map_manager.right and position.y >= 0:
			# Vector stores floats, so convert to int for dictionary keys.
			# post-processing, so cache should be filled
			if heights[int(position.x)] == position.y:
				return true
	return false

# Tests if tile is exposed to water
func _is_tile_exposed_water_level(x, y):
	var pos = Vector2(x, y)
	# check left, right, top and bottom of tile for air
	var positions = [pos + Vector2.LEFT,
		pos + Vector2.RIGHT,
		pos + Vector2.UP,
		pos + Vector2.DOWN]

	for position in positions:
		# Don't check if < height, because that's the
		# 	primary condition we're testing.
		if position.x >= layer.map_manager.left and position.x <= layer.map_manager.right and position.y >= 0:
			# Vector stores floats, so convert to int for dictionary keys.
			# post-processing, so cache should be filled
			if heights[int(position.x)] <= position.y and position.y <= water_level:
				return true
	return false
