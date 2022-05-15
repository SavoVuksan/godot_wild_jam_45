extends RigidBody2D
class_name PlayerController

signal velocity_changed(velocity)

enum players {PLAYER_1=1,PLAYER_2=2}

export(players) var player_controller = 1
export(float) var movement_speed = 100
export(float) var jump_height = 100
export(int) var max_jumps = 1


var jumps_performed : int = 0

onready var animated_sprite = $AnimatedSprite

func _integrate_forces(state):
	var movement =  Input.get_axis(_get_action_string("move_left"),_get_action_string("move_right")) * movement_speed
	state.linear_velocity.x = movement

	if Input.is_action_just_pressed(_get_action_string("jump")) && jumps_performed < max_jumps:
		jumps_performed += 1
		state.linear_velocity.y = 0
		state.apply_central_impulse(Vector2.UP * jump_height * gravity_scale)

	emit_signal("velocity_changed",linear_velocity)

func _on_JumpHitBox_body_entered(body):
	jumps_performed = 0

func _get_action_string(name:String) -> String:
	return "p" + String(player_controller) + "_" + name
