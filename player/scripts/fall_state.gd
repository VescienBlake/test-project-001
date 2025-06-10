extends NodeState


@export var character_body_2d: CharacterBody2D
@export var animated_sprite_2d: AnimatedSprite2D
@export var speed:= 300.0
@export var coyote_time_duration := 0.2
var coyote_timer := 0.0


func _on_process(_delta : float) -> void:
	pass


func _on_physics_process(_delta : float) -> void:
	GameInputEvents.apply_gravity(character_body_2d, _delta)
	
	# Coyote timer countdown
	coyote_timer = max(coyote_timer - _delta, 0.0)
	
	# Horizontal movement input
	var direction = GameInputEvents.movement_input()
	character_body_2d.velocity.x = direction * speed
	
	
	character_body_2d.move_and_slide()


func _on_next_transitions() -> void:
	# Jump input during coyote time
	if GameInputEvents.jump_input() and coyote_timer > 0.0:
		transition.emit("Jump")
		
	# Idle state
	if character_body_2d.is_on_floor():
		transition.emit("Idle")
		
	# Dash state
	#elif GameInputEvents.dash_input() and DashCooldown.can_dash:
		#transition.emit("Dash")
		
	# Attack state
	elif GameInputEvents.attack_input():
		transition.emit("Attack")


func _on_enter() -> void:
	coyote_timer = coyote_time_duration
	animated_sprite_2d.play("fall")


func _on_exit() -> void:
	animated_sprite_2d.stop()
