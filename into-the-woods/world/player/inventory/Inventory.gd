extends GridContainer

export (Texture)var normal_texture
export (Texture)var selected_texture

var selected_slot setget _selected_slot_set,_selected_slot_get

func _selected_slot_set(value):
	if value < 0 or value >= size:
		print("[ERROR] Failed to set selected inventory slot to ", value, " because it's outside of the valid range.")
		return

	get_child(selected_slot).texture = normal_texture	# revert previously selected slot
	selected_slot = value
	get_child(selected_slot).texture = selected_texture # update newly selected slot

func _selected_slot_get():
	return selected_slot

var size

func _ready():
	size = columns
	selected_slot = 0

func switch_object(idx):
	pass

func add_object(obj):
	var n = 0
	while n < size and get_child(n).has_object():
		n += 1

	if n == size:
		# no room
		return false
	else:
		get_child(n).set_object(obj)
		return true

func remove_object(obj):
	for child in get_children():
		if child.get_object() == obj:
			child.clear_object()
			return true
	# doesn't exist in inventory
	return false
