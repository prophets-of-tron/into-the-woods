extends Node
class_name Generator

var GeneratorManager = load("res://generator/GeneratorManager.gd")

var gen_manager

func _find_gen_manager(node:Node):
	# it's just a Node container
	if node is GeneratorManager:
		return node
	return _find_gen_manager(node.get_parent())

func _ready():
	gen_manager = _find_gen_manager(get_parent())

# Called when the stack at x is registered as "processed"
# Note that in the case of structures, this does not
#	necessarily mean that the stack is generated yet.
func process_stack(x):
	pass