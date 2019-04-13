extends ObjectGenerator

const stick_scene = preload("res://object/stick/Stick.tscn")

export(int) var spread

var forest_info
var constants

func _ready():
	forest_info = get_node("/root/World/Info/ForestInfo")
	constants = get_node("/root/Constants")

func process_stack(x):
	if x % spread != 0 or not forest_info.is_forest(x):
		return
		
	var node = stick_scene.instance()
	node.position = constants.tile_size * Vector2(x, -(terrain_info.sample_height(x) + 1))
	objects.add_child(node)