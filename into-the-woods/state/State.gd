extends Node

# TODO? make more protected
var seed_hash
var noise

func _ready():
	# gen random seed
	randomize()
	seed_hash = randi()
	
	# set game's state to that scene
	seed(seed_hash)
	# softnoise
	noise = OpenSimplexNoise.new()
	noise.seed = seed_hash