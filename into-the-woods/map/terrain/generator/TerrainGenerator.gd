extends "res://map/generator/TileGenerator.gd"

signal stack_generated(x)
signal tile_generated(x, y)	# we probably won't need to use this

export(float) var height_harshness
export(int) var min_height
export(int) var max_height

var dirt
var grass

var heights = {}	# 1d heightmap cache

var constants
var state

func _ready():
	._ready()
	
	constants = get_node("/root/Constants")
	state = get_node("/root/State")
	
	var tileset = map.tile_set
	dirt = tileset.find_tile_by_name("Dirt")
	grass = tileset.find_tile_by_name("Grass")

func sample_height(x):
	# cache
	if heights.has(x):
		return heights[x]
		
	var nz = state.noise.get_noise_2d(height_harshness * x, 0)
	var height = floor(min_height + (max_height - min_height) * (nz + 1) / 2)
	heights[x] = height
	return height

func gen_stack(x):
	for y in range(sample_height(x)):
		# replace dirt that's exposed to air to grass after next stack's generation
		var type = dirt
		map.set_cell(x, y, type)
		# after _ready (add_child)
		emit_signal("tile_generated", x, y)
		
	# apply post-generation touches (dirt -> grass) to the existing neighbor
	# this works because in Map#gen_stack, this gen_stack is called 
	# 	before updating left and right
	var a_stack = map.left != +INF and map.right != -INF
	if a_stack:
		var existing_neighbor_x
		if x == map.left - 1:
			existing_neighbor_x = x + 1
		elif x == map.right + 1:
			existing_neighbor_x = x - 1
		else:
			# uh-oh
			pass	# let existing_neighbor_x remain underfined
		update_dirt_grass_stack(existing_neighbor_x)
	
	emit_signal("stack_generated", x)
	
func update_dirt_grass_stack(x):
	# Calculate if the tile is exposed to air or not.
	# If exposed to air, replace with a grass tile.
	# (Stack should already be generated!)
	for y in range(heights[x]):
		if _is_tile_exposed(x, y) and map.get_cell(x, y) == dirt:
			map.set_cell(x, y, grass)

"""HELPER"""

# Tests if tile is exposed to air
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
		if position.x >= map.left and position.x <= map.right and position.y >= 0:
			# Vector stores floats, so convert to int for dictionary keys.
			# INVALID_CELL means no tile exists there 
			#	(which means air, given the above conditions).
			if map.get_cell(int(position.x), int(position.y)) == map.INVALID_CELL:
				return true
	return false