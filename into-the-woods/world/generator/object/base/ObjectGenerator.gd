extends Generator
class_name ObjectGenerator

signal object_generated(object, x, y)

var objects
var terrain_info
var terrain_map

func _ready():
	objects = get_node("/root/Game/World/Objects")
	terrain_info = get_node("/root/Game/World/Info").find_node("TerrainInfo", true)
	terrain_map = get_node("/root/Game/World/TerrainMap")

func load_stack(x, file):
	pass	# TODO

func unload_stack(x, file):
	pass	# TODO
