extends TileLayer
class_name StructureLayer

var constants

func _ready():
	._ready()
	
	constants = get_node("/root/Constants")
