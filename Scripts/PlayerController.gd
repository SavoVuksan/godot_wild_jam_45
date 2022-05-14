extends RigidBody2D


export(float) var movement_speed = 100
export(float) var jump_height = 100
export(int) var max_jumps = 1
export(float) var air_time = 0.2

var jumps_performed : int = 0

onready var animated_sprite = $AnimatedSprite

func _integrate_forces(state):
	var movement =  Input.get_axis("p1_move_left","p1_move_right") * movement_speed
	state.linear_velocity.x = movement

	if Input.is_action_just_pressed("p1_jump") && jumps_performed < max_jumps:
		jumps_performed += 1
		state.linear_velocity.y = 0
		state.apply_central_impulse(Vector2.UP * jump_height * gravity_scale)


	

func _on_JumpHitBox_body_entered(body):
	jumps_performed = 0


