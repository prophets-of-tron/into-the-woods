extends Node2D

var Stack = preload("stack/Stack.tscn")

export(int) var width

func gen():
	for x in range(width):
		var stack = Stack.instance()
		add_child(stack)
		# after _ready
		stack.x = x
		stack.gen()

func _ready():
	gen()
