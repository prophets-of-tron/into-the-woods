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

func set_object(obj: RigidBody2D):
	# drop current object, if there is one
	clear_object(obj)
	
	objects.remove_child(obj)
	obj.mode = RigidBody2D.MODE_STATIC
	obj.rotation = 0
	add_child(obj)
	obj.position = self.texture.get_size() / 2
	