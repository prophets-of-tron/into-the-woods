extends Generator

signal terrain_stack_generated(x)
signal terrain_tile_generated(x, y)	# we probably won't need to use this

var terrain_info
var layer
var constants

func _ready():
	terrain_info = get_node("/root/World/Info/TerrainInfo")
	layer = get_node("/root/World/Map/TerrainLayer")
	constants = get_node("/root/Constants")

func _gen_stack(x):
	for y in range(terrain_info.sample_height(x)):
		# replace dirt that's exposed to air to grass after next stack's generation
		var type = layer.dirt
		layer.set_cell(x, y, type)
		emit_signal("terrain_tile_generated", x, y)

	for y in range(terrain_info.sample_height(x), terrain_info.water_level):
		layer.set_cell(x, y, layer.water)

	emit_signal("terrain_stack_generated", x)

# TODO: add this method to TileGenerator
func _post_gen_stack(x):
	# Calculate if the tile is exposed to air or not.
	# If exposed to air, replace with a grass tile.
	# (Stack should already be generated!)

	# Turn all tiles that touch a block at water level to sand
	# Turn dirt that is exposed to air to grass

	for y in range(terrain_info.heights[x]):
		if _is_tile_sand(x, y):
			layer.set_cell(x, y, layer.sand)
		elif _is_tile_exposed(x, y):
			if layer.get_cell(x, y) == layer.dirt:
				layer.set_cell(x, y, layer.grass)

func process_stack(x):
	# generate current stack
	_gen_stack(x)

	# apply post-generation touches (dirt -> grass) to the existing neighbor
	# this works because in Map#gen_stack, this gen_stack is called
	# 	before updating left and right
	var a_stack = gen_manager.left != +INF and gen_manager.right != -INF
	if a_stack:
		var existing_neighbor_x
		if x == gen_manager.left - 1:
			existing_neighbor_x = x + 1
		elif x == gen_manager.right + 1:
			existing_neighbor_x = x - 1
		else:
			# uh-oh
			pass	# let existing_neighbor_x remain underfined
		_post_gen_stack(existing_neighbor_x)


"""Local helpers"""

# Tests if tile is exposed to air (water, along with structures, is ignored)
func _is_tile_exposed(x, y):
	var pos = Vector2(x, y)
	# check left, right, top and bottom of tile for air
	var positions = [pos + Vector2.LEFT,
		pos + Vector2.RIGHT,
		pos + Vector2.UP,
		pos + Vector2.DOWN]

	for position in positions:
		# Don't check if < height, because that's the
		# 	primary condition we're testing.
		if position.x >= gen_manager.left and position.x <= gen_manager.right and position.y >= 0:
			# Vector stores floats, so convert to int for dictionary keys.
			# post-processing, so cache should be filled
			if terrain_info.heights[int(position.x)] <= position.y:
				return true
	return false

# Tests if tile is exposed to water
func _is_tile_sand(x, y):
	# this method must be called in post-processing, so cache should be filled
	# we could have used terrain_info.sample_height(x) as well
	var h = terrain_info.heights[x]
	if y != h - 1:
		return false	# must be top tile (currently)
	
	# Sand cannot exceed water_level, plus a constant (tiles_sand_above_water)
	return h <= terrain_info.sand_level
