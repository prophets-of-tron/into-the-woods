extends Generator
class_name StructureGenerator

# emitted when entire stucture is generated (x == structure origin's x)
signal structure_generated(x)
signal structure_tile_generated(x, y)

var structures
var terrain_info
var terrain_layer

func _ready():
	structures = get_node("/root/World/Structures")
	terrain_info = get_node("/root/World/Info").find_node("TerrainInfo", true)
	terrain_layer = get_node("/root/World/Map").find_node("TerrainLayer", true)

func can_generate(x):
	return false

func gen_structure(x):
	pass

func process_stack(x):
	if can_generate(x):
		gen_structure(x)
