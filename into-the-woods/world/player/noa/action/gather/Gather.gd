extends NOA

const Flint = preload("res://world/object/flint/Flint.tscn")

var terrain_map
var terrain_info
var constants

func _ready():
	._ready()
	
	terrain_map = get_node("/root/Game/World/TerrainMap")
	terrain_info = get_node("/root/Game/World/Info/TerrainInfo")
	constants = get_node("/root/Constants")

func perform():
	var player_tile_x = int(floor(player.position.x / constants.tile_size))
	var found = null
	if terrain_map.get_top_tile(player_tile_x) == terrain_map.sand:
		found = _search_sand()
		
	if found != null:
		player.inventory.add_object(found)
		
func _search_sand():
	# There's a chance of finding flint on shores 
	# 	(simply sand at least for now)
	# TODO: somehow get probability from inspector
	if randi() % 8 == 0:
		return Flint.instance()
		
	return null
	