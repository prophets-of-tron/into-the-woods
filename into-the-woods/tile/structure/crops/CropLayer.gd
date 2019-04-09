extends StructureLayer

# PUT TILE TYPE REFERENCES HERE AS NEEDED
var corn

func _ready():
	corn = tile_set.find_tile_by_name("Corn")
