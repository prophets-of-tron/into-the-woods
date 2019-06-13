# Stores, manages and renders a single object in the inventory

extends TextureRect

var player
var objects

func _ready():
	player = get_node("/root/Game/World/Player")
	objects = get_node("/root/Game/World/Objects")

func get_action():
	return get_child(0)

func perform():
	get_action().perform()
