extends ObjectGenerator

const Rock = preload("res://object/rock/Rock.tscn")

export(int) var harsh_noise_multiplier = 1
export(float) var harsh_noise_threshold
export(int) var spread = 1

var constants

func _ready():
	constants = get_node("/root/Constants")
	
func process_stack(x):
	var submerged = terrain_info.sample_height(x) <= terrain_info.water_level
	if x % spread != 0 or submerged:
		return

	if not state.harsh_noise.get_noise_2d(harsh_noise_multiplier * x, unique_seed) >= harsh_noise_threshold:
		return
	
	var node = Rock.instance()
	node.position = constants.tile_size * Vector2(x, -(terrain_info.sample_height(x) + 1))
	objects.add_child(node)