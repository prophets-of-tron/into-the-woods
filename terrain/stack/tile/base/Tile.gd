extends Node2D

var y:int setget y_set, y_get

var constants
	
func y_set(value):
	y = value
	# multiply position index by scale, because scale should equal height
	transform.origin.y = constants.tile_size * value
func y_get():
	return y
	
func _ready():
	constants = get_node("/root/Constants")
	# set scale to constants.tile_size
	# node should be a 1px by 1px in the editor
	scale = Vector2(constants.tile_size, constants.tile_size)
	