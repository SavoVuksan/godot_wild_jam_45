extends Node


enum states {IDLE,RUNNING,JUMPING,FALLING}

export(states) var state 

onready var animated_sprite = get_parent().get_node("AnimatedSprite")

func _on_PlayerController_velocity_changed(velocity:Vector2):
	if velocity.x < 0:
		animated_sprite.flip_h = true
	if velocity.x > 0:
		animated_sprite.flip_h = false
	
	match state:
		states.IDLE:
			animated_sprite.animation = "Idle"
			
			if velocity.x != 0:
				state = states.RUNNING
			if velocity.y < 0:
				state = states.JUMPING
			if velocity.y > 0:
				state = states.FALLING
		
		states.RUNNING:
			animated_sprite.animation = "Run"
			
			if velocity.x == 0:
				state = states.IDLE
			if velocity.y < -1:
				state = states.JUMPING
			if velocity.y > 1:
				state = states.FALLING
		
		states.JUMPING:
			animated_sprite.animation = "Jump"
			
			if velocity.y > 0:
				state = states.FALLING

		states.FALLING:
			animated_sprite.animation = "Fall"
			
			if velocity.y == 0:
				if velocity.x == 0:
					state = states.IDLE
				else:
					state = states.RUNNING
