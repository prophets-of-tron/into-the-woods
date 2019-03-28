extends Node2D

signal stack_generated(stack)
signal tile_generated(tile)	# we probably won't need to use this

var Stack = preload("stack/Stack.tscn")

export(int) var width

func on_Stack_tile_generated(tile):
	emit_signal("tile_generated", tile)

func gen():
	for x in range(width):
		var stack = Stack.instance()
		stack.connect("tile_generated", self, "on_Stack_tile_generated")
		add_child(stack)
		# after _ready
		stack.x = x
		stack.gen()
		emit_signal("stack_generated", stack)

func _ready():
	gen()
	
func get_stack_(x):
	# if x >= width, error should be called
	var stack = get_child(x)
	
	if stack.x != x:
		# todo: error
		print("Invalid terrain stack order")
		return null
	return stack
	
func get_tile(x, y):
	var stack = get_stack_(x)
	if stack != null:
		return stack.get_tile(y)
	return null

# helper
func is_tile_exposed(x, y):
	var pos = Vector2(x, y)
	# check left, right, top and bottom of tile for air
	var positions = [pos + Vector2(-1, 0),
		pos + Vector2(+1, 0),
		pos + Vector2(0, -1),
		pos + Vector2(0, +1)]
		
	for position in positions:
		if position.x >= 0 and position.x < width and position.y >= 0:
			if get_tile(position.x, position.y) == null:
				return true	
	return false