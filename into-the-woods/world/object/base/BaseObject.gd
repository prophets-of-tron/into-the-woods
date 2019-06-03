extends RigidBody2D
# class_name may cause circular references in some cases :/
class_name BaseObject

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

func _ready():
	pass
