extends Node

# noise input factors for location
export(float) var location_multiplier
#export(float) var location_multiplier_type
# lowest noise that can generate a tree
export(float) var noise_offset
export(float) var noise_threshold
#export(float) var random_threshold

var terrain_map
var state

func _ready():
	terrain_map = get_node("/root/Game/World/TerrainMap")
	state = get_node("/root/State")

func is_forest(x):
	if typeof(x) != TYPE_INT:
		print("[WARN] Non-int input to sample_height: " + x)
		x = int(x)
		
	var top = terrain_map.get_top_tile(x)
	if top != terrain_map.dirt and top != terrain_map.grass:
		return false
	
	return state.smooth_noise.get_noise_2d(x * location_multiplier, noise_offset) >= noise_threshold