extends GridContainer

export (Texture)var normal_texture
export (Texture)var selected_texture

# the index of the selected slot
var selected setget _selected_set,_selected_get

func _selected_set(value):
	if value < 0 or value >= size:
		print("[ERROR] Failed to set selected inventory slot to ", value, " because it's outside of the valid range.")
		return

	var before = get_child(selected)
	before.texture = normal_texture	# revert previously selected slot

	selected = value

	var after = get_child(selected)
	after.texture = selected_texture # update newly selected slot

func _selected_get():
	return selected

var size

func _ready():
	size = columns
	selected = 0
