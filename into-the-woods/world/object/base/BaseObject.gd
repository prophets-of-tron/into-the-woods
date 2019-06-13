extends RigidBody2D
# class_name may cause circular references in some cases :/
class_name BaseObject

# set to the player when in inventory and null when not
var player = null

func _ready():
	pass

func _enter_tree():
	# cancel out world being flipped vertically
	scale.y *= -1

# hold item
func equip():
	pass

# perform primary action
func primary():
	pass

# perform secondary action
func secondary():
	pass

# unhold item
func unequip():
	pass
