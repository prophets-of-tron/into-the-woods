extends Node

# noise input factors for location
export(float) var location_multiplier
#export(float) var location_multiplier_type
# lowest noise that can generate a tree
export(float) var noise_offset
export(float) var noise_threshold
#export(float) var random_threshold

var terrain_layer
var state

func _ready():
	terrain_layer = get_node("/root/World/Map/TerrainLayer")
	state = get_node("/root/State")

func is_forest(x):
	var top = terrain_layer.get_top_tile(x)
	if top != terrain_layer.dirt and top != terrain_layer.grass:
		return null
	
	return state.smooth_noise.get_noise_2d(x * location_multiplier, noise_offset) >= noise_threshold