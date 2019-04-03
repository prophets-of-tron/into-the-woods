extends Node
class_name TileGenerator

var map		# 2d tilemap

func _find_map(node:Node):
	if node is TileMap:
		return node
	return _find_map(node.get_parent())

func _ready():
	# traverse up tree until the TileMap node is found
	map = _find_map(self)	# or _find_map(get_parent())

func gen_stack(x):
	pass