extends TileMap
class_name TileLayer

var MapManager = load("res://tile/MapManager.gd")

var generators = []
var map_manager		# contains all TileGenerator s

func _find_map_manager(node:Node):
	# it's just a Node container
	if node is MapManager:
		return node
	return _find_map_manager(node.get_parent())
	
func _ready():
	# traverse up tree until the parent of all layers is found
	map_manager = _find_map_manager(get_parent())

func process_stack(x):
	for generator in generators:
		generator.process_stack(x)