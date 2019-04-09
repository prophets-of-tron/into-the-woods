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

# traverses hierarchy and calls generators
# generator is a node
func _register_generator(node:Node):
	if node.get_child_count() > 0:	# redundent but for readability
		for child in node.get_children():
			_register_generator(child)	# our dear friend recursion
	var generator = node as TileGenerator
	if generator == null:
		# give them the benefit of the doubt; it's a container node
		return
	
	generators.append(generator)
	
func _ready():
	# traverse up tree until the parent of all layers is found
	map_manager = _find_map_manager(get_parent())
	
	_register_generator(self)	# register hierarchy

func process_stack(x):
	for generator in generators:
		generator.process_stack(x)