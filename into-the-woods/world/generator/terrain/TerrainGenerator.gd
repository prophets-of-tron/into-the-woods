extends Generator

signal terrain_stack_generated(x)
signal terrain_tile_generated(x, y)	# we probably won't need to use this

var terrain_info
var map
var constants

func _ready():
	terrain_info = get_node("/root/Game/World/Info/TerrainInfo")
	map = get_node("/root/Game/World/TerrainMap")
	constants = get_node("/root/Game/Constants")

func _gen_stack(x):
	# NOTE: The world is flipped vertically in the inspector.

	# Generate up to (but not including) height sample.
	# 	This will result in the right stack height.
	for y in range(0, terrain_info.sample_height(x)):
		# replace dirt that's exposed to air to grass after next stack's generation
		var type = map.dirt
		map.set_cell(x, y, type)
		emit_signal("terrain_tile_generated", x, y)

	for y in range(terrain_info.sample_height(x), terrain_info.water_level):
		map.set_cell(x, y, map.water)

	emit_signal("terrain_stack_generated", x)

# TODO: add this method to TileGenerator
func _post_gen_stack(x):
	# Calculate if the tile is exposed to air or not.
	# If exposed to air, replace with a grass tile.
	# (Stack should already be generated!)

	# Turn all dirt that is exposed to air to grass
	# Turn all tiles in the sand height range to sand

	for y in range(0, terrain_info.heights[x]):
		if _is_tile_exposed(x, y):
			if map.get_cell(x, y) == map.dirt:
				map.set_cell(x, y, map.grass)
		if _is_tile_sand(x, y):
			map.set_cell(x, y, map.sand)

func process_stack(x):
	# generate current stack
	_gen_stack(x)

	# apply post-generation touches (dirt -> grass) to the existing neighbor
	# this works because in MapManager#process_stack, this process_stack is called
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
			pass	# let existing_neighbor_x remain undefined
		_post_gen_stack(existing_neighbor_x)


"""Local helpers"""

# Tests if tile is exposed to air (water, along with structures, is ignored)
func _is_tile_exposed(x, y):
	var pos = Vector2(x, y)
	# check left, right, top and bottom of tile for air
	var neighbor_positions = [pos + Vector2.LEFT,
		pos + Vector2.RIGHT,
		pos + Vector2.UP,
		pos + Vector2.DOWN]

	for neighbor_pos in neighbor_positions:
		# Don't check if < height here, because that's the
		# 	primary condition we're testing.
		if neighbor_pos.x >= gen_manager.left and neighbor_pos.x <= gen_manager.right and neighbor_pos.y >= 0:
			# Vector stores floats, so convert to int for dictionary keys.
			# This is in post-processing, so cache should be filled.
			# If this test position is above the top of the stack, then it is air.
			if neighbor_pos.y >= terrain_info.heights[int(neighbor_pos.x)]:
				return true
	return false

# Tests if tile is exposed to water
func _is_tile_sand(x, y):
	# This method must be called in post-processing, so cache should be filled.
	# We could have used terrain_info.sample_height(x) as well.
	var h = terrain_info.heights[x]
	# Test if top of the stack
	if y < h - 1:
		return false	# sand is only on the top tile (currently)

	# Sand cannot exceed water_level, plus a constant (TerrainInfo#tiles_sand_above_water)
	return y < terrain_info.sand_level
