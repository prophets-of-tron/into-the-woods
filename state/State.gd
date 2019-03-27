extends Node

var preNoiseScript = preload("res://util/softnoise.gd")

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
	noise = preNoiseScript.SoftNoise.new(seed_hash)