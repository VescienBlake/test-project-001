extends NodeState

@export var character_body_2d: CharacterBody2D
@export var animated_sprite_2d: AnimatedSprite2D

@export var dash_speed = 400
var facing_right = true
@export var dash_duration:= 0.4
var dash_timer:= 0.0


func _on_process(_delta : float) -> void:
	pass
	

func _on_physics_process(_delta : float) -> void:
	# Disables gravity
	character_body_2d.velocity.y = 0
	
	# Dash timer countdown
	dash_timer = max(dash_timer - _delta, 0.0)
	
	# Flips sprite
	if animated_sprite_2d.flip_h == false:
		facing_right = true
	else:
		facing_right = false
	
	# Apply dash direction
	character_body_2d.velocity.x = dash_speed if facing_right else -dash_speed

	character_body_2d.move_and_slide()

func _on_next_transitions() -> void:
	if dash_timer <= 0.0:
		if character_body_2d.is_on_floor():
			transition.emit("Idle")
		else:
			transition.emit("Fall")

func _on_enter() -> void:
	dash_timer = dash_duration
	animated_sprite_2d.play("dash")


func _on_exit() -> void:
	character_body_2d.velocity.x = 0
	animated_sprite_2d.stop()
