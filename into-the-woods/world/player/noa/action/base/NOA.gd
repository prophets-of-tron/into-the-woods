extends TextureRect
class_name NOA

var player:Player

func _ready():
	player = get_node("/root/Game/World/Player")

# TODO? maybe there should be an 'action' type, of which
# 	BaseObject has two (primary + secondary) and from
#	which this class extends.
func perform():
	pass
