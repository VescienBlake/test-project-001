extends NodeState


@export var character_body_2d: CharacterBody2D
@export var animated_sprite_2d: AnimatedSprite2D
@export var jump_force = 300.0
@export var acceleration = 300.0
@export var jump_amount = 1
@export_range(0, 1) var decelerate_on_release = 0.5
@export var jump_buffer_duration:= 0.2
var jump_buffer:= 0.0


func _on_process(_delta : float) -> void:
	pass


func _on_physics_process(_delta : float) -> void:
	GameInputEvents.apply_gravity(character_body_2d, _delta)
	
	var direction: float = GameInputEvents.movement_input()
	character_body_2d.velocity.x = direction * acceleration
	
	jump_buffer = max(jump_buffer - _delta, 0.0)
	
	# Variable jump 
	if not Input.is_action_pressed("jump") and character_body_2d.velocity.y < 0:
		character_body_2d.velocity.y *= decelerate_on_release
		
	# Jump
	if character_body_2d.is_on_floor():
		character_body_2d.velocity.y = -jump_force
	
	# Flips sprite
	if direction:
		animated_sprite_2d.flip_h = false if direction > 0 else true
		
	# Buffered jump 
	if GameInputEvents.jump_input():
		jump_buffer = jump_buffer_duration
	if character_body_2d.is_on_floor() and jump_buffer > 0.0:
		animated_sprite_2d.stop()
		character_body_2d.velocity.y = -jump_force
		animated_sprite_2d.play("jump")
		jump_buffer = 0.0
		
	# Double jump
	elif GameInputEvents.jump_input() and jump_amount > 0 and not character_body_2d.is_on_floor():
		animated_sprite_2d.stop()
		character_body_2d.velocity.y = -jump_force
		animated_sprite_2d.play("jump")
		jump_amount -= 1
			
	character_body_2d.move_and_slide()
	
	
func _on_next_transitions() -> void:
	# Idle state
	if character_body_2d.is_on_floor() and jump_buffer == 0.0:
		transition.emit("Idle")
		
	# Dash state
	elif GameInputEvents.dash_input():
		transition.emit("Dash")
		
	# Attack state
	elif GameInputEvents.attack_input():
		transition.emit("Attack")


func _on_enter() -> void:
	jump_amount = 1
	character_body_2d.velocity.y = -jump_force
	animated_sprite_2d.play("jump")
	

func _on_exit() -> void:
	animated_sprite_2d.stop()
