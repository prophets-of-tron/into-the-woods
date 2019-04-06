extends Node
class_name TileGenerator

var map:TileMap		# 2d tilemap

var DIRT
var GRASS
var WATER
var SAND

func _find_map(node:Node):
	if node is TileMap:
		return node
	return _find_map(node.get_parent())

func _ready():
	# traverse up tree until the TileMap node is found
	map = _find_map(self)	# or _find_map(get_parent())

	var tile_set = map.tile_set
	DIRT = tile_set.find_tile_by_name("Dirt")
	GRASS = tile_set.find_tile_by_name("Grass")
	WATER = tile_set.find_tile_by_name("Water")
	SAND = tile_set.find_tile_by_name("Sand")

func process_stack(x):
	pass
