extends Node2D

func _ready():
	# flip y-axis
	scale.y = -1
	position.y = get_viewport().size.y
