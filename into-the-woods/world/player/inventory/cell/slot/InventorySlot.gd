# Stores, manages and renders a single object in the inventory

extends TextureRect

var player
var objects

func _ready():
	player = get_node("/root/Game/World/Player")
	objects = get_node("/root/Game/World/Objects")

func has_object():
	return get_child_count() == 1

func get_object():
	return get_child(0) if has_object() else null

func clear_object(obj):
	if has_object():
		obj.mode = RigidBody2D.MODE_RIGID
		remove_child(get_child(0))
		obj.position = player.position
		objects.add_child(obj)

		obj.player = null

func set_object(obj):
	# drop current object, if there is one
	clear_object(obj)

	objects.remove_child(obj)
	obj.mode = RigidBody2D.MODE_STATIC
	obj.rotation = 0
	add_child(obj)
	obj.position = self.texture.get_size() / 2

	obj.player = player

func equip():
	var obj = get_object()
	if obj != null:
		obj.equip()

# uses the object the primary way
func primary():
	var obj = get_object()
	if obj != null:
		obj.primary()

# uses the object the primary way
func secondary():
	var obj = get_object()
	if obj != null:
		obj.secondary()

func unequip():
	var obj = get_object()
	if obj != null:
		obj.unequip()
