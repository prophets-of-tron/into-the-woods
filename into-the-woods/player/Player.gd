extends KinematicBody2D

export(int) var gravity
export(int) var acceleration
export(int) var max_speed
export(int) var jump_height
export(float) var friction_coeff

var motion = Vector2()

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
			
	motion = move_and_slide(motion, Vector2.UP)