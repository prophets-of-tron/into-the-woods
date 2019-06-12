extends StructureGenerator

const CornStructure = preload("res://world/structure/corn/CornPlant.tscn")

# distance between tree origins
# Trees can never overlap, so don't let that haPPEN.
export(int) var spread

export(float) var smooth_noise_multiplier = 1
export(float) var smooth_noise_threshold	# lowest noise that can generate a tree
export(int) var harsh_noise_offset	# to make unique from smooth noise calls
export(int) var harsh_noise_multiplier = 1
export(float) var harsh_noise_threshold

#var max_radius

var forest_info
var layer
var constants

func _ready():
	#_calc_max_radius()
	forest_info = get_node("/root/Game/World/Info/ForestInfo")
	layer = get_node("/root/Game/World/Map/Structure/CropLayer")
	constants = get_node("/root/Constants")

#func _calc_max_radius():
#	max_radius = 0
#	for child in get_children():
#		max_radius = max(max_radius, child.radius)

func _is_plant_at(x):
	if x % spread != 0:
		print("Invalid x value for corn plant origin!")
		return

	# TEST EXISTANCE

	var top = terrain_map.get_top_tile(x)
	if top != terrain_map.dirt and top != terrain_map.grass:
		return false
	if forest_info.is_forest(x):
		return false	# don't spawn in forest

	# define 'corn areas'
	var smooth_true = state.smooth_noise.get_noise_2d(smooth_noise_multiplier * x, unique_seed) >= smooth_noise_threshold
	# leave pseudo-random gaps
	var harsh_true = state.harsh_noise.get_noise_2d(harsh_noise_multiplier * x + harsh_noise_offset, unique_seed) >= smooth_noise_threshold
	if not (smooth_true and harsh_true):
		return false

	return true

func can_generate(x):
	var closest_plant_x = int(spread * floor(float(x) / spread + 0.5))
	# if stack is processed, then terrain is generated
	return gen_manager.is_stack_processed(closest_plant_x) and _is_plant_at(closest_plant_x)

func gen_structure(x):
	# potential origin (on the plant grid)
	var closest_plant_plant_x = int(floor(float(x) / spread + 0.5))
	# in tiles
	var closest_plant_x = int(spread * closest_plant_plant_x)
	var base_elevation = terrain_info.sample_height(closest_plant_x)

	var structure = CornStructure.instance()
	var structure_y = -base_elevation
	# structure origin
	structure.position = constants.tile_size * Vector2(closest_plant_x, structure_y)
	structures.add_child(structure)		# add to world

	emit_signal("structure_generated", structure, closest_plant_x, structure_y)
