extends Node2D
# class_name may cause circular references in some cases :/
class_name BaseObject

var type:int setget type_set,type_get
var _is_ready = false

func type_get():
	return type

func type_set(t):
	type = t
	if _is_ready:
		var tile_node = get_node("/root/Tiles").get_child(type)
		$Sprite.texture = tile_node.texture
	# else handle it on _ready

func _ready():
	var constants = get_node("/root/Constants")
	
	# for some reason, can't set scale of rigidbody, so do it to all children for now
	$Sprite.scale = Vector2(constants.tile_size, constants.tile_size)
	if type != null:
		var tile_node = get_node("/root/Tiles").get_child(type)		
		$Sprite.texture = tile_node.texture
	
	var half = constants.tile_size / 2
	$CollisionShape.get_shape().extents = Vector2(half, half)
	
	_is_ready = true