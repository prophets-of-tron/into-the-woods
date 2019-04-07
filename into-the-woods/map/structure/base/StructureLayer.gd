extends TileLayer
class_name StructureLayer

const BaseObjectScene = preload("res://object/BaseObject.tscn")

var constants

func _ready():
	._ready()
	
	constants = get_node("/root/Constants")

# converts the tile at (x, y) to an object
func remove_tile(x, y):
	var type = get_cell(x, y)
	set_cell(x, y, -1)
	# tile_set.tres must be up-to-date (TODO: check if works)
	var obj = BaseObjectScene.instance()
	obj.layer = self
	obj.type = type
	obj.position = map_to_world(Vector2(x, -y))
	# account for centering by adding half
	obj.position += Vector2(.5 * constants.tile_size, -.5 * constants.tile_size)
	
	get_node("/root/World/Objects").add_child(obj)