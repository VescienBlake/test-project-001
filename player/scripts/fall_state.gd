extends NodeState


@export var character_body_2d: CharacterBody2D
@export var animated_sprite_2d: AnimatedSprite2D
@export var speed:= 300.0

func _on_process(_delta : float) -> void:
	pass


func _on_physics_process(_delta : float) -> void:
	GameInputEvents.apply_gravity(character_body_2d, _delta)
	
	# Horizontal movement input
	var direction = GameInputEvents.movement_input()
	character_body_2d.velocity.x = direction * speed
	
	if direction:
		animated_sprite_2d.flip_h = false if direction > 0 else true
	
	character_body_2d.move_and_slide()


func _on_next_transitions() -> void:
	# Idle state
	if character_body_2d.is_on_floor():
		transition.emit("Idle")
		
	# Dash state
	elif GameInputEvents.dash_input():
		transition.emit("Dash")


func _on_enter() -> void:
	animated_sprite_2d.play("fall")


func _on_exit() -> void:
	animated_sprite_2d.stop()
