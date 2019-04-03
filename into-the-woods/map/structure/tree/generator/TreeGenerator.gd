extends "res://map/generator/TileGenerator.gd"

# emitted when entire tree is generated (x == origin of tree)
signal tree_generated(x)
# emitted when one stack of tree is generated
signal stack_generated(x)
# yes
signal tile_generated(x, y)

const TerrainGenerator = preload("res://map/terrain/generator/TerrainGenerator.gd")

# distance between tree origins
# Trees can never overlap, so don't let that haPPEN.
export(int) var tree_distance
# noise input factors for location
export(float) var location_multiplier_exists
#export(float) var location_multiplier_type
# lowest noise that can generate a tree
export(float) var noise_threshold
#export(float) var random_threshold

var state
var terrain:TerrainGenerator

func _ready():
	._ready()
	
	state = get_node("/root/State")
	terrain = map.find_node("TerrainGenerator", true)

# tree_x is the index of the potential tree on the tree grid
# 	(can be negative)
func _get_tree_at(tree_x):
	var exists = state.noise.get_noise_2d(tree_x * location_multiplier_exists, 0)
	if exists < noise_threshold:
		return null
	# for now just return the only tree;
	# 	simplex noise isn't evenly distributed, so it would
	#	be bad to choose from a list with thattt
	return get_child(0)
	
	# Note: the list of trees == the children of TreeGenerator
	
func gen_stack(x):
	# potential origin (on the tree grid)
	var closest_tree_tree_x = floor(float(x) / tree_distance + 0.5)
	# in tiles
	var closest_tree_x = tree_distance * closest_tree_tree_x
	
	var tree = _get_tree_at(closest_tree_tree_x)
	if tree == null:
		return
		
	# terrain height at the tree's origin
	# The terrain stack does *not* need to be generated first 
	# (- 1) to account for the zero-indexing system
	var base_elevation = terrain.sample_height(closest_tree_x) - 1
	
	var sample_x = x - closest_tree_x
	for sample_y in range(-tree.height, 0):
		var sample = tree.get_cell(sample_x, sample_y)
		# if greater than -1
		if sample > map.INVALID_CELL:
			# flip y-axis (TODO it's gross, think about this)
			map.set_cell(x, base_elevation - sample_y, sample)