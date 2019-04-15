extends Generator
class_name ObjectGenerator

signal object_generated(object, x, y)

var objects
var terrain_info
var terrain_layer

func _ready():
	objects = get_node("/root/World/Objects")
	terrain_info = get_node("/root/World/Info").find_node("TerrainInfo", true)
	terrain_layer = get_node("/root/World/Map").find_node("TerrainLayer", true)
