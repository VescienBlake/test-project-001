extends NodeState

@export var character_body_2d: CharacterBody2D
@export var animated_sprite_2d: AnimatedSprite2D

@export var jump_force = 300.0
@export var acceleration = 300.0
@export var jump_amount = 2
@export_range(0, 1) var decelerate_on_release = 0.5


func _on_process(_delta : float) -> void:
	pass


func _on_physics_process(_delta : float) -> void:
	GameInputEvents.apply_gravity(character_body_2d, _delta)
	
	var direction: float = GameInputEvents.movement_input()
	character_body_2d.velocity.x = direction * acceleration
	
	# Flip sprite
	if direction:
		animated_sprite_2d.flip_h = false if direction > 0 else true
	
	# Jump
	if character_body_2d.is_on_floor():
		jump_amount = 2
		character_body_2d.velocity.y = -jump_force
		jump_amount -= 1
	
	# Double jump
	if jump_amount > 0 and not character_body_2d.is_on_floor():
		if GameInputEvents.jump_input():
			character_body_2d.velocity.y = -jump_force
			jump_amount -= 1
			
	# Variable jump 
	if Input.is_action_just_released("jump") and character_body_2d.velocity.y < 0:
		character_body_2d.velocity.y *= decelerate_on_release
	
	character_body_2d.move_and_slide()
	

func _on_next_transitions() -> void:
	# Fall state
	if jump_amount == 0:
		transition.emit("Fall")

	# Idle state
	elif character_body_2d.is_on_floor():
		transition.emit("Idle")
		
	# Dash state
	elif GameInputEvents.dash_input():
		transition.emit("Dash")


func _on_enter() -> void:
	animated_sprite_2d.play("jump")

func _on_exit() -> void:
	animated_sprite_2d.stop()
