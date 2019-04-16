extends TileMap

var terrain_info

var dirt
var grass
var water
var sand

func _ready():
	terrain_info = get_node("/root/World/Info/TerrainInfo")
	
	dirt = tile_set.find_tile_by_name("Dirt")
	grass = tile_set.find_tile_by_name("Grass")
	water = tile_set.find_tile_by_name("Water")
	sand = tile_set.find_tile_by_name("Sand")

func get_top_tile(x):
	return get_cell(x, -(terrain_info.sample_height(x) - 1))
