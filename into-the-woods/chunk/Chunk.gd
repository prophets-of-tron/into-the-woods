extends TileMap

var chunk_x = 0	# 0 is the default value for isolated testing

var last_stack_x = 0	# rightmost stack that's completely generated
var heightmap = {}	# for convenience

func gen():
	var generators = get_node("/root/World/Generators")
	generators \
		.get_node("TerrainGenerator") \
		.gen_chunk(self)

func _ready():
	# flip y-axis
	scale.y = -1
	position.y = get_viewport().size.y
	
	gen()