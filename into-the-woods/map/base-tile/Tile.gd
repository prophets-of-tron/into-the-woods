extends Node2D

func _ready():
	var constants = get_node("/root/Constants")
	
	# set scale to constants.tile_size
	# node should be a 1px by 1px in the editor
	scale = Vector2(constants.tile_size, constants.tile_size)