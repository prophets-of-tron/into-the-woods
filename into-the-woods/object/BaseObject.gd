extends Node2D
# class_name may cause circular references in some cases :/
class_name BaseObject

var layer = null
var type = -1

func _ready():
	var constants = get_node("/root/Constants")
	
	# for some reason, can't set scale of rigidbody, so do it to all children for now
	$Sprite.scale = Vector2(constants.tile_size, constants.tile_size)
	if layer == null or type == -1:
		print("Must set BaseObject's layer and type immediately")
	
	# All layers must have a child called TileSet,
	#	which is the scene used to export that layer's
	#	tile set.
	var tile_node = layer.get_node("TileSet").get_child(type)		
	$Sprite.texture = tile_node.texture
	
	var half = constants.tile_size / 2
	$CollisionShape.get_shape().extents = Vector2(half, half)