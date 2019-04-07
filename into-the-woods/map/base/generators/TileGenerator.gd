extends Node
class_name TileGenerator

# to prevent cyclic dependencies
var TileLayer = load("res://map/base/TileLayer.gd")
var MapManager = load("res://map/MapManager.gd")

var layer
var map_manager		# contains all TileGenerator s

func _find_map_manager(node:Node):
	# it's just a Node container
	if node is MapManager:
		return node
	return _find_map_manager(node.get_parent())

func _find_layer(node:Node):
	if node is TileLayer:
		return node
	return _find_layer(node.get_parent())
	
func _ready():
	layer = _find_layer(get_parent())
	map_manager = _find_map_manager(get_parent())

# Registers the stack at x to be generated
# Note that in the case of structures, this does not
#	necessarily mean that the stack is generated yet.
func process_stack(x):
	pass