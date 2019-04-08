extends TileLayer

var dirt
var grass
var water
var sand

func _ready():
	._ready()
	
	dirt = tile_set.find_tile_by_name("Dirt")
	grass = tile_set.find_tile_by_name("Grass")
	water = tile_set.find_tile_by_name("Water")
	sand = tile_set.find_tile_by_name("Sand")
