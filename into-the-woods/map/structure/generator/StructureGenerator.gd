extends TileGenerator
class_name StructureGenerator

# emitted when entire stucture is generated (x == structure origin's x)
signal structure_generated(x)
signal structure_tile_generated(x, y)

const TerrainGenerator = preload("res://map/terrain/generator/TerrainGenerator.gd")

var terrain:TerrainGenerator

func _ready():
	terrain = map.find_node("TerrainGenerator", true)

func can_generate(x):
	return false

func gen_structure(x):
	pass

func process_stack(x):
	if can_generate(x):
		gen_structure(x)
