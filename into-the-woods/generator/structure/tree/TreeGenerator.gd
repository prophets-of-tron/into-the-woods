extends StructureGenerator

# distance between tree origins
# Trees can never overlap, so don't let that haPPEN.
export(int) var spread

#var max_radius

var forest_info
var layer

func _ready():
	#_calc_max_radius()
	forest_info = get_node("/root/World/Info/ForestInfo")
	layer = get_node("/root/World/Map/Structure/TreeLayer")

#func _calc_max_radius():
#	max_radius = 0
#	for child in get_children():
#		max_radius = max(max_radius, child.radius)

# tree_x is the index of the potential tree on the tree grid
# 	(can be negative)
func _get_tree_at(x):
	
	if not forest_info.is_forest(x):
		return null
		
	# for now don't proc-gen it but use a template
	# also, there is only one type of tree atm
	return get_child(0)

	# Note: the list of trees == the children of CornGenerator

func can_generate(x):
	var closest_tree_x = spread * floor(float(x) / spread + 0.5)
	# if stack is processed, then terrain is generated
	return gen_manager.is_stack_processed(closest_tree_x)

func gen_structure(x):
	# potential origin (on the tree grid)
	var closest_tree_tree_x = floor(float(x) / spread + 0.5)
	# in tiles
	var closest_tree_x = spread * closest_tree_tree_x

	var tree = _get_tree_at(closest_tree_x)
	if tree == null:
		return

	var base_elevation = terrain_info.sample_height(closest_tree_x) - 1

	for sample_x in range(-tree.radius, +tree.radius):
		for sample_y in range(-tree.height, 0):
			var sample = tree.get_cell(sample_x, sample_y)
			# if greater than -1
			if sample > TileMap.INVALID_CELL:
				var world_x = closest_tree_x + sample_x
				var world_y = base_elevation - sample_y
				# flip y-axis (TODO it's gross, think about this)
				layer.set_cell(world_x, world_y, sample)
				emit_signal("structure_tile_generated", world_x, world_y)

	emit_signal("structure_generated", closest_tree_x)
