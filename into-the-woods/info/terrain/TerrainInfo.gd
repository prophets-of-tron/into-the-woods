extends Node

export(float) var height_harshness
export(int) var min_height
export(int) var max_height
export(int) var water_level
export(int) var tiles_sand_above_water

var heights = {}	# 1d heightmap cache
var sand_level

var state

func _ready():
	sand_level = water_level + tiles_sand_above_water
	state = get_node("/root/State")

# Excludes water in calculation
func sample_height(x):
	if typeof(x) != TYPE_INT:
		print("[WARN] Non-int input to sample_height: " + x)
		x = int(x)
	# cache
	if heights.has(x):
		return heights[x]

	var nz = state.smooth_noise.get_noise_2d(height_harshness * x, 0)
	var height = floor(min_height + (max_height - min_height) * (nz + 1) / 2)
	heights[x] = height
	return height
