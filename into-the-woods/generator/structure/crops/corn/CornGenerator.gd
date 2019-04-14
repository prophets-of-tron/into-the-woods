extends StructureGenerator

# distance between tree origins
# Trees can never overlap, so don't let that haPPEN.
export(int) var spread

export(float) var smooth_noise_multiplier
export(float) var smooth_noise_threshold	# lowest noise that can generate a tree
export(float) var harsh_noise_offset	# to make unique from smooth noise calls
export(float) var harsh_noise_threshold

#var max_radius

var forest_info
var layer

func _ready():
	#_calc_max_radius()
	forest_info = get_node("/root/World/Info/ForestInfo")
	layer = get_node("/root/World/Map/Structure/CropLayer")

#func _calc_max_radius():
#	max_radius = 0
#	for child in get_children():
#		max_radius = max(max_radius, child.radius)

func _get_plant_at(x):
	if x % spread != 0:
		print("Invalid x value for corn plant origin!")
		return
	
	# TEST EXISTANCE
	
	var top = terrain_layer.get_top_tile(x)
	if top != terrain_layer.dirt and top != terrain_layer.grass:
		return null
	if forest_info.is_forest(x):
		return	# don't spawn in forest
	
	# define 'corn areas'
	var smooth_true = state.smooth_noise.get_noise_2d(x * smooth_noise_multiplier, unique_seed) >= smooth_noise_threshold
	# leave pseudo-random gaps
	var harsh_true = state.harsh_noise.get_noise_2d(x + harsh_noise_offset, unique_seed) >= smooth_noise_threshold
	if not (smooth_true and harsh_true):
		return null
		
	# CHOOSE TYPE
		
	# for now just return the only tree;
	# 	simplex noise isn't evenly distributed, so it would
	#	be bad to choose from a list with thattt
	return get_child(0)

	# Note: the list of trees == the children of TreeGenerator

func can_generate(x):
	var closest_plant_x = int(spread * floor(float(x) / spread + 0.5))
	# if stack is processed, then terrain is generated
	return gen_manager.is_stack_processed(closest_plant_x) and _get_plant_at(closest_plant_x) != null

func gen_structure(x):
	# potential origin (on the plant grid)
	var closest_plant_plant_x = int(floor(float(x) / spread + 0.5))
	# in tiles
	var closest_plant_x = int(spread * closest_plant_plant_x)

	var plant = _get_plant_at(closest_plant_x)
	# shouldn't be null

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
