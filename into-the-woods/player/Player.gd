extends KinematicBody2D

export(int) var gravity
export(int) var acceleration
export(int) var max_speed
export(int) var jump_height
export(float) var friction_coeff

# TODO: get actual width with code (definitely)
export(int) var width
export(int) var height
export(float) var snap_dist

var motion = Vector2()
var jumping = false

func _physics_process(delta):
	motion.y += gravity
	
	var moving = false
	if Input.is_key_pressed(KEY_A):
		motion.x = max(motion.x - acceleration, -max_speed)
		moving = true
	if Input.is_key_pressed(KEY_D):
		motion.x = min(motion.x + acceleration, +max_speed)
		moving = true
	if not moving:
		# apply friction
		motion.x = lerp(motion.x, 0, friction_coeff)
		
	if is_on_floor():
		if Input.is_key_pressed(KEY_SPACE):
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