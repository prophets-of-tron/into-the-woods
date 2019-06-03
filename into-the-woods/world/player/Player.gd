extends KinematicBody2D
class_name Player

export(int) var load_distance
export(int) var reach

export(int) var gravity
export(int) var acceleration
export(int) var max_speed
export(int) var max_speed_cheat
export(int) var jump_height
export(float) var friction_coeff	# is this really the friction coeff.?

# TODO: get actual width with code (definitely)
export(int) var width
export(int) var height
export(float) var snap_dist

var motion = Vector2()
var jumping = false

var gen_manager:GeneratorManager
var inv
var objects
var state
var util
var constants

func _ready():
	# TODO: is it ok to reference other scenes so much? lol
	gen_manager = get_node("/root/Game/World/Generator")
	inv = get_node("HUD/Inventory")
	state = get_node("/root/State")
	objects = get_node("/root/Game/World/Objects")
	util = get_node("/root/Util")
	constants = get_node("/root/Constants")

func _get_settings_input():
	if Input.is_action_just_pressed("bypass_constraints"):
		state.bypass_constraints = not state.bypass_constraints
	if Input.is_action_just_pressed("screenshot_mode"):
		state.screenshot_mode = not state.screenshot_mode
		visible = not state.screenshot_mode

func _check_collect_object():
	if Input.is_action_just_pressed("collect_object"):
		# Get closest object to player, if any within range
		var closest_dist = INF	# doesn't exist
		var closest_obj = null
		for object in objects.get_children():
			var dist = object.position.distance_to(self.position)
			if dist < closest_dist and dist <= reach:
				closest_dist = dist
				closest_obj = object

		if closest_obj:
			inv.add_object(closest_obj)

func _get_input():
	_get_settings_input()
	_check_collect_object()

func _process(delta):
	_get_input()

func _check_switch_object(event):
	if event is InputEventMouseButton and event.is_pressed():
		if event.button_index == BUTTON_WHEEL_DOWN:
			inv.selected_slot = Util.positive_mod(inv.selected_slot - 1, inv.size)
		if event.button_index == BUTTON_WHEEL_UP:
			inv.selected_slot = Util.positive_mod(inv.selected_slot + 1, inv.size)

func _input(event):
	_check_switch_object(event)

func _check_load():
	# Load chunks, if player is in semi-new territory
	var pos_tile_x = int(floor(position.x / constants.tile_size))
	var pos_left = pos_tile_x - load_distance
	var pos_right = pos_tile_x + load_distance

	# note that the player can activate both triggers in the same frame
	# 	(i.e. the first frame)
	if pos_left <= gen_manager.left:
		# start at map.left and go backwads;
		# 	otherwise map.left will get messed up by the calls to
		#	map.gen_stack (which updates map.left (and map.right))
		for x in range(gen_manager.left - 1, pos_left, -1):
			gen_manager.process_stack(x)
	if pos_right >= gen_manager.right:
		for x in range(gen_manager.right + 1, pos_right, +1):
			gen_manager.process_stack(x)

func _physics_process(delta):
	motion.y += gravity

	var curr_max_speed = max_speed_cheat if state.bypass_constraints else max_speed

	var moving = false
	if Input.is_action_pressed("move_left"):
		motion.x = max(motion.x - acceleration, -curr_max_speed)
		moving = true
	if Input.is_action_pressed("move_right"):
		motion.x = min(motion.x + acceleration, +curr_max_speed)
		moving = true
	if not moving:
		# apply friction
		motion.x = lerp(motion.x, 0, friction_coeff)

	if is_on_floor():
		if Input.is_action_pressed("jump"):
			motion.y = jump_height
			jumping = true
		else:
			jumping = false

	# TODO: uncomment the following code and figure out
	# snapping to the ground when walking down hills

	# # don't snap if jumping (set the snap vector to 0,0)
	# var below_center = Vector2(width / 2, height + snap_dist) if not jumping else Vector2()
	# motion = move_and_slide_with_snap(motion, below_center, Vector2.UP)
	motion = move_and_slide(motion, Vector2.UP)

	_check_load()
