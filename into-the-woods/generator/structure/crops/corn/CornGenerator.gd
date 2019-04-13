extends StructureGenerator

# distance between tree origins
# Trees can never overlap, so don't let that haPPEN.
export(int) var spread
# noise input factors for location
export(float) var location_multiplier
#export(float) var location_multiplier_type
# lowest noise that can generate a tree
export(float) var noise_threshold
#export(float) var random_threshold

#var max_radius

var layer
var terrain_layer
var state

func _ready():
	#_calc_max_radius()
	layer = get_node("/root/World/Map/Structure/CropLayer")
	terrain_layer = get_node("/root/World/Map/TerrainLayer")
	state = get_node("/root/State")

#func _calc_max_radius():
#	max_radius = 0
#	for child in get_children():
#		max_radius = max(max_radius, child.radius)

# plant_x is the index of the potential tree on the tree grid
# 	(can be negative)
func _get_plant_at(plant_x):
	var top = terrain_layer.get_top_tile(plant_x * spread)
	if top != terrain_layer.dirt and top != terrain_layer.grass:
		return null
	var exists = state.noise.get_noise_2d(plant_x * location_multiplier, 0)
	if exists > noise_threshold:	# spawn where trees aren't (roughly)
		return null
	# for now just return the only tree;
	# 	simplex noise isn't evenly distributed, so it would
	#	be bad to choose from a list with thattt
	return get_child(0)

	# Note: the list of trees == the children of TreeGenerator

func can_generate(x):
	var closest_plant_x = spread * floor(float(x) / spread + 0.5)
	# if stack is processed, then terrain is generated
	return gen_manager.is_stack_processed(closest_plant_x)

func gen_structure(x):
	# potential origin (on the tree grid)
	var closest_plant_tree_x = floor(float(x) / spread + 0.5)
	# in tiles
	var closest_plant_x = spread * closest_plant_tree_x

	var plant = _get_plant_at(closest_plant_tree_x)
	if plant == null:
		return

	var base_elevation = terrain_info.sample_height(closest_plant_x) - 1

	for sample_x in range(-plant.radius, +plant.radius):
		for sample_y in range(-plant.height, 0):
			var sample = plant.get_cell(sample_x, sample_y)
			# if greater than -1
			if sample > TileMap.INVALID_CELL:
				var world_x = closest_plant_x + sample_x
				var world_y = base_elevation - sample_y
				# flip y-axis (TODO it's gross, think about this)
				layer.set_cell(world_x, world_y, sample)
				emit_signal("structure_tile_generated", world_x, world_y)

	emit_signal("structure_generated", closest_plant_x)
