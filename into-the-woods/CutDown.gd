extends Action

var crop_layer:TileLayer

func _ready():
	._ready()
	
	crop_layer = map_manager.find_node("CropLayer")

func _process(delta):
	if Input.is_key_pressed(KEY_C):
		# tile position of the origin of the arms (where player can reach from)
		var tile_pos = crop_layer.world_to_map(player.get_node("Arms").global_position)
		tile_pos.y /= -1
		var reach_squared = player.reach * player.reach
		# TODO: only include tiles in front of the player (by facing direction)
		for x in range(int(tile_pos.x) - player.reach, int(tile_pos.x) + player.reach):
			for y in range(int(tile_pos.y) - player.reach, int(tile_pos.y) + player.reach):
				if tile_pos.distance_squared_to(Vector2(x, y)) <= reach_squared:
					if crop_layer.get_cell(x, y) == crop_layer.corn:
						crop_layer.remove_tile(x, y)
						break	# only one at a time