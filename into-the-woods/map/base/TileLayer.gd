extends TileMap
class_name TileLayer

var MapManager = load("res://map/MapManager.gd")

var map_manager		# contains all TileGenerator s

func _find_map_manager(node:Node):
	# it's just a Node container
	if node is MapManager:
		return node
	return _find_map_manager(node.get_parent())

func _ready():
	# traverse up tree until the parent of all layers is found
	map_manager = _find_map_manager(get_parent())

# traverses hierarchy and calls generators
# generator is a node
func _process_node(node:Node, x):
	if node.get_child_count() > 0:	# redundent but for readability
		for child in node.get_children():
			_process_node(child, x)	# our dear friend recursion
	var generator = node as TileGenerator
	if generator == null:
		# give them the benefit of the doubt; it's a container node
		return
	
	generator.process_stack(x)
	
func process_stack(x):
	_process_node(self, x)