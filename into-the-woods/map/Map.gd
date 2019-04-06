extends TileMap
class_name Map

const BaseObjectScene = preload("res://object/BaseObject.tscn")

var left = +INF
var right = -INF

var constants
var tiles:Node

func _ready():
	constants = get_node("/root/Constants")
	# set cell size
	# set manually to 8, because problems with cell scaling
	#cell_size = Vector2(constants.tile_size, constants.tile_size)
	tiles = get_node("/root/Tiles")
	
	# flip y-axis
	scale.y = -1
	#position.y = get_viewport().size.y
	
	# Generate a single stack at x=0, because Player#check_load
	# only generates to the left and right of x=0
	gen_stack(0)

# traverses hierarchy and calls generators
# generator is a node
func _process_node(node:Node, x):
	if node.get_child_count() > 0:	# redundent but for readability
		for child in node.get_children():
			_process_node(child, x)	# our dear friend recursion
	var generator = node as TileGenerator
	if generator == null:
		# give them the benefit of the doubt; it's a container node
		return
	
	generator.process_stack(x)

func gen_stack(x):
	if is_stack_processed(x):
		print("probably shouldn't be re-generating stack@x="+str(x))
		# already generated
		return
	
	_process_node(self, x)
	
	left = min(left, x)
	right = max(right, x)
	
func is_stack_processed(x):
	return x >= left and x <= right

# converts the tile at (x, y) to an object
func remove_tile(x, y):
	var type = get_cell(x, y)
	set_cell(x, y, -1)
	# tile_set.tres must be up-to-date (TODO: check if works)
	var obj = BaseObjectScene.instance()
	obj.type = type
	obj.position = map_to_world(Vector2(x, -y))
	# account for centering by adding half
	obj.position += Vector2(.5 * constants.tile_size, -.5 * constants.tile_size)
	
	get_node("/root/World/Objects").add_child(obj)