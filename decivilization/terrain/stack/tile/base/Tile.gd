extends Node2D

var constants

var terrain

var x:int setget ,x_get
var y:int setget y_set, y_get	# TODO? replace with get_index()

func x_get():
	return get_parent().x
	
func y_set(value):
	y = value
	# multiply position index by scale, because scale should equal height
	transform.origin.y = constants.tile_size * value
func y_get():
	return y
	
func _ready():
	constants = get_node("/root/Constants")
	
	terrain = get_node("../..")		# parent stack's parent
	
	# set scale to constants.tile_size
	# node should be a 1px by 1px in the editor
	scale = Vector2(constants.tile_size, constants.tile_size)