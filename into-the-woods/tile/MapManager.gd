extends Node2D
class_name MapManager

var layers = []
var constants

# traverses hierarchy and collects layers
func _register_layer(node:Node):
	if node.get_child_count() > 0:	# redundent but for readability
		for child in node.get_children():
			_register_layer(child)	# our dear friend recursion
	var layer = node as TileLayer
	if layer == null:
		# give them the benefit of the doubt; it's a container node
		return
	
	layers.append(layer)

func _ready():
	constants = get_node("/root/Constants")
	# set cell size
	# set manually to 8, because problems with cell scaling
	#cell_size = Vector2(constants.tile_size, constants.tile_size)
	#_register_layer(self)

	# flip y-axis
	scale.y = -1
	#position.y = get_viewport().size.y
	