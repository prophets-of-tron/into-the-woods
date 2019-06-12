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
	if before != null:
		before.texture = normal_texture	# revert previously selected slot
		before.get_object().unequip()

	selected = value

	var after = get_child(selected)
	if after != null:
		after.texture = selected_texture # update newly selected slot
		after.get_object().equip()

func _selected_get():
	return selected

var size

func _ready():
	size = columns
	selected = 0

func add_object(obj):
	var n = 0
	while n < size and get_child(n).has_object():
		n += 1

	if n == size:
		# no room
		return false
	else:
		get_child(n).set_object(obj)
		if n == selected:
			get_child(n).equip()
		return true

func remove_object(obj):
	for child in get_children():
		if child.get_object() == obj:
			if obj == get_child(selected).get_object():
				child.unequip()
			child.clear_object()
			return true
	# doesn't exist in inventory
	return false
