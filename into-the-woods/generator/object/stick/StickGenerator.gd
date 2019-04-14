extends ObjectGenerator

const stick_scene = preload("res://object/stick/Stick.tscn")

export(float) var harsh_noise_threshold

export(int) var spread

var forest_info
var constants

func _ready():
	forest_info = get_node("/root/World/Info/ForestInfo")
	constants = get_node("/root/Constants")

func process_stack(x):
	if not (x % spread == 0 and forest_info.is_forest(x)):
		return
	if not state.harsh_noise.get_noise_2d(x, unique_seed) >= harsh_noise_threshold:
		return
		
	var node = stick_scene.instance()
	node.position = constants.tile_size * Vector2(x, -(terrain_info.sample_height(x) + 1))
	objects.add_child(node)