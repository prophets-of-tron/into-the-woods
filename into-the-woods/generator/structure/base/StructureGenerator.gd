extends Generator
class_name StructureGenerator

# emitted when entire stucture is generated (x == structure origin's x)
signal structure_generated(structure, x, y)
signal structure_tile_generated(tile, x, y)

var structures
var terrain_info
var terrain_map

func _ready():
	structures = get_node("/root/World/Structures")
	terrain_info = get_node("/root/World/Info").find_node("TerrainInfo", true)
	terrain_map = get_node("/root/World/TerrainMap")

func can_generate(x):
	return false

func gen_structure(x):
	pass

func process_stack(x):
	if can_generate(x):
		gen_structure(x)
