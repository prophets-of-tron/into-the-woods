extends Generator
class_name ObjectGenerator

var objects
var terrain_info

func _ready():
	objects = get_node("/root/World/Objects")
	terrain_info = get_node("/root/World/Info").find_node("TerrainInfo", true)
