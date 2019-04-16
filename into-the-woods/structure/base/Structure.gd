extends Area2D
class_name Structure

var constants

func _ready():
	constants = get_node("/root/Constants")
	if (fmod(position.x, 1) != 0 or fmod(position.y, 1) != 0) \
		or (int(position.x) % constants.tile_size != 0) or (int(position.y) % constants.tile_size != 0):
		print("Structure not on grid: (", position.x, ", ", position.y, ")!")
