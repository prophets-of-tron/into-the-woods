extends TileMap

var chunk_x = 0	# 0 is the default value for isolated testing

func gen():
	$Terrain.chunk = self
	$Terrain.gen()

func _ready():
	# flip y-axis
	scale.y = -1
	position.y = get_viewport().size.y
	
	gen()