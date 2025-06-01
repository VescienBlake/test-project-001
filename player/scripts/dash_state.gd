extends NodeState

@export var character_body_2d: CharacterBody2D
@export var animated_sprite_2d: AnimatedSprite2D

@export var dash_speed = 700
var facing_right = true
var is_dashing = false
var dash_finished = false
var can_dash = true


func _on_process(_delta : float) -> void:
	pass

func _on_physics_process(_delta : float) -> void:
	character_body_2d.velocity.y = 0
	
	if animated_sprite_2d.flip_h == false:
		facing_right = true
	else:
		facing_right = false

	if is_dashing:
		character_body_2d.velocity.x = dash_speed if facing_right else -dash_speed

	character_body_2d.move_and_slide()

func _on_next_transitions() -> void:
	if dash_finished:
		dash_finished = false
		if character_body_2d.is_on_floor():
			transition.emit("Idle")
		else:
			transition.emit("Fall")

func _on_enter() -> void:
	is_dashing = true
	can_dash = false
	character_body_2d.velocity.x = dash_speed if facing_right else -dash_speed
	animated_sprite_2d.play("dash")
	dash_timer()
	dash_cooldown()

func _on_exit() -> void:
	character_body_2d.velocity.x = 0
	animated_sprite_2d.stop()

func dash_timer():
	await get_tree().create_timer(0.2).timeout
	is_dashing = false
	dash_finished = true

func dash_cooldown():
	await get_tree().create_timer(3.0).timeout
	can_dash = true
