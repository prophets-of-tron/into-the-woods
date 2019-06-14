extends StructureGenerator

# in future, distinguish between different types of trees (Tree0, etc.)
const TreeStructure = preload("res://world/structure/tree/tree0/Tree0.tscn")

# distance between tree origins
# Trees can never overlap, so don't let that haPPEN.
export(int) var spread

#var max_radius

var forest_info
var layer
var constants

func _ready():
	#_calc_max_radius()
	forest_info = get_node("/root/Game/World/Info/ForestInfo")
	layer = get_node("/root/Game/World/Map/Structure/TreeLayer")
	constants = get_node("/root/Constants")

#func _calc_max_radius():
#	max_radius = 0
#	for child in get_children():
#		max_radius = max(max_radius, child.radius)

func _is_tree_at(x):
	if x % spread != 0:
		print("Invalid tree x-coord!")
		return

	return forest_info.is_forest(x)

func can_generate(x):
	var closest_tree_x = int(spread * floor(float(x) / spread + 0.5))
	# if stack is processed, then terrain is generated
	return gen_manager.is_stack_processed(closest_tree_x) and _is_tree_at(closest_tree_x)

func gen_structure(x):
	# potential origin (on the tree grid)
	var closest_tree_tree_x = int(floor(float(x) / spread + 0.5))
	# in tiles
	var closest_tree_x = int(spread * closest_tree_tree_x)
	var base_elevation = terrain_info.sample_height(closest_tree_x)

	# Don't worry about water, because forest_info doesn't
	# register water as forest

	var structure = TreeStructure.instance()
	# structure origin
	structure.position = constants.tile_size * Vector2(closest_tree_x, base_elevation)
	structures.add_child(structure)		# add to world

	emit_signal("structure_generated", structure, closest_tree_x, base_elevation)
