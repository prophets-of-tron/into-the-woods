extends Node

export(float) var height_harshness
export(int) var min_height
export(int) var max_height
export(int) var water_level
export(int) var rel_sand_height

var heights = {}	# 1d heightmap cache

var state

func _ready():
	state = get_node("/root/State")

# Excludes water in calculation
func sample_height(x):
	# cache
	if heights.has(x):
		return heights[x]

	var nz = state.noise.get_noise_2d(height_harshness * x, 0)
	var height = floor(min_height + (max_height - min_height) * (nz + 1) / 2)
	heights[x] = height
	return height
