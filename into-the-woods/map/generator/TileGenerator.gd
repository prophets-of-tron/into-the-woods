extends Node
class_name TileGenerator

var map:TileMap		# 2d tilemap

var dirt
var grass
var water
var sand

func _find_map(node:Node):
	if node is TileMap:
		return node
	return _find_map(node.get_parent())

func _ready():
	# traverse up tree until the TileMap node is found
	map = _find_map(self)	# or _find_map(get_parent())

	var tile_set = map.tile_set
	dirt = tile_set.find_tile_by_name("Dirt")
	grass = tile_set.find_tile_by_name("Grass")
	water = tile_set.find_tile_by_name("Water")
	sand = tile_set.find_tile_by_name("Sand")

func process_stack(x):
	pass
