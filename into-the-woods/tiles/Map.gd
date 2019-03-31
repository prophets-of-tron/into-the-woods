extends TileMap

var left = +INF
var right = -INF

func gen_stack(x):
	if x >= left and x <= right:
		# already generated
		return
		
	
	$TerrainGenerator.gen_stack(x)
	left = min(left, x)
	right = max(right, x)

func _ready():
	# flip y-axis
	scale.y = -1
	#position.y = get_viewport().size.y
	
	# Generate a single stack at x=0, because Player#check_load
	# only generates to the left and right of x=0
	gen_stack(0)