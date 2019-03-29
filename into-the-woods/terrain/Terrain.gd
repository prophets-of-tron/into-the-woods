extends Node2D

signal stack_generated(stack)
signal tile_generated(tile)	# we probably won't need to use this

var Stack = preload("stack/Stack.tscn")

var left = 0
var right = 150
var stacks = {}

func on_Stack_tile_generated(tile):
	emit_signal("tile_generated", tile)

func gen():
	for x in range(left, right):
		var stack = Stack.instance()
		stack.connect("tile_generated", self, "on_Stack_tile_generated")
		add_child(stack)
		# after _ready
		stack.x = x
		stack.gen()
		stacks[x] = stack
		emit_signal("stack_generated", stack)

func _ready():
	gen()
	
func get_stack_(x):
	# if y < 0, error should be called, and I hope
	# querying a key that does not exist will raise an error
	# so don't do anything
	
	return stacks[x]
	
func get_tile(x, y):
	var stack = get_stack_(x)
	if stack != null:
		return stack.get_tile(y)
	return null

"""HELPER"""

# Tests if tile is exposed to air
func is_tile_exposed(x, y):
	var pos = Vector2(x, y)
	# check left, right, top and bottom of tile for air
	var positions = [pos + Vector2(-1, 0),
		pos + Vector2(+1, 0),
		pos + Vector2(0, -1),
		pos + Vector2(0, +1)]
		
	for position in positions:
		# don't check if < height, because that's the primary condition we're testing
		if position.x >= left and position.x <= right and position.y >= 0:
			# vector stores floats, so convert to int for dictionary
			if get_tile(int(position.x), int(position.y)) == null:
				return true
	return false