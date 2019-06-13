extends ObjectGenerator

const Stick = preload("res://world/object/stick/Stick.tscn")

export(int) var harsh_noise_multiplier = 1
export(float) var harsh_noise_threshold

export(int) var spread

var forest_info
var constants

func _ready():
	forest_info = get_node("/root/Game/World/Info/ForestInfo")
	constants = get_node("/root/Constants")

func process_stack(x):
	if not (x % spread == 0 and forest_info.is_forest(x)):
		return
	if not state.harsh_noise.get_noise_2d(harsh_noise_multiplier * x, unique_seed) >= harsh_noise_threshold:
		return

	var node = Stick.instance()
	var height = terrain_info.sample_height(x)
	node.position = constants.tile_size * Vector2(x, height)
	objects.add_child(node)

	emit_signal("object_generated", node, x, height)
