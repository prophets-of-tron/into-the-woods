extends Node

# lol... dev cheats FTW
var bypass_constraints = false

# TODO? make more protected
var seed_hash
var smooth_noise
var harsh_noise

var unique_seeds = []

func _ready():
	# gen random seed
	randomize()
	seed_hash = randi()
	
	# set game's state to that scene
	seed(seed_hash)

	smooth_noise = OpenSimplexNoise.new()
	smooth_noise.seed = randi()
	harsh_noise = OpenSimplexNoise.new()
	harsh_noise.octaves = 1
	harsh_noise.period = 1
	harsh_noise.seed = randi()

func get_unique_seed():
	# state of random number generator shouldn't matter here
	var unique_seed = randi()
	if unique_seeds.has(unique_seed):
		return get_unique_seed()	# recursion is our friend :'D
	unique_seeds.append(unique_seed)
	return unique_seed