extends Node

signal chunk_generated(chunk_x)
signal stack_generated(chunk_x, x)
signal tile_generated(chunk_x, x, y)	# we probably won't need to use this

export(float) var height_harshness
export(int) var min_height
export(int) var max_height

const DIRT = 0
const GRASS = 1

var constants
var state

func gen_stack(chunk, x):
	var nz = state.noise.perlin_noise2d(height_harshness * x, state.seed_hash)
	var height = floor(min_height + (max_height - min_height) * (nz + 1) / 2)
	chunk.heightmap[x] = height
	for y in range(height):
		# replace dirt that's exposed to air to grass after next stack's generation
		var type = DIRT
		chunk.set_cell(x, y, type)
		# after _ready (add_child)
		emit_signal("tile_generated", chunk.chunk_x, x, y)
		
	# listen in order to turn	dirt -> grass
	emit_signal("stack_generated", chunk.chunk_x, x)
	chunk.last_stack_x = max(chunk.last_stack_x, x)
	
func update_dirt_grass_stack(chunk, x):
	# Calculate if the tile is exposed to air or not.
	# If exposed to air, replace with a grass tile.
	for y in range(chunk.heightmap[x]):
		if _is_tile_exposed(chunk, x, y) and chunk.get_cell(x, y) == DIRT:
			chunk.set_cell(x, y, GRASS)

func gen_chunk(chunk):
	for x in range(0, constants.chunk_width + 1):
		gen_stack(chunk, x)
		
	# Update all stacks except the last one.
	for x in range(0, constants.chunk_width):
		# We know that all stacks around it are generated.
		update_dirt_grass_stack(chunk, x)
	emit_signal("chunk_generated", chunk.chunk_x)

func _ready():
	constants = get_node("/root/Constants")
	state = get_node("/root/State")

"""HELPER"""

# Tests if tile is exposed to air
func _is_tile_exposed(chunk, x, y):
	var pos = Vector2(x, y)
	# check left, right, top and bottom of tile for air
	var positions = [pos + Vector2.LEFT,
		pos + Vector2.RIGHT,
		pos + Vector2.UP,
		pos + Vector2.DOWN]
		
	for position in positions:
		# Don't check if < height, because that's the 
		# 	primary condition we're testing.
		if position.x >= 0 and position.x <= chunk.last_stack_x and position.y >= 0:
			# Vector stores floats, so convert to int for dictionary keys.
			# INVALID_CELL means no tile exists there 
			#	(which means air, given the above conditions).
			if chunk.get_cell(int(position.x), int(position.y)) == chunk.INVALID_CELL:
				return true
	return false