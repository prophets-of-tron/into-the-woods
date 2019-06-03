extends GridContainer

var selected_slot = 0

var size

func _ready():
	size = columns
	
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