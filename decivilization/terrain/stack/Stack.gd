extends Node2D

export(float) var heightHarshness
export(int) var minHeight
export(int) var maxHeight

var Grass = preload("tile/grass/Grass.tscn")

var constants
var state

var x:int setget x_set, x_get
var height:int

func x_set(value):
	x = value
	transform.origin.x = constants.tile_size * value
func x_get():
	return x

func gen():
	var nz = state.noise.perlin_noise2d(heightHarshness * x, state.seed_hash)
	height = floor(minHeight + (maxHeight - minHeight) * (nz + 1) / 2)
	for y in range(height):
		var type = Grass
		var tile = type.instance()
		add_child(tile)
		# after _ready (add_child)
		tile.y = y

func _ready():
	constants = get_node("/root/Constants")
	state = get_node("/root/State")
