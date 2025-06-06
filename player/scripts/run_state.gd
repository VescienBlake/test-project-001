extends NodeState

@export var character_body_2d: CharacterBody2D
@export var animated_sprite_2d: AnimatedSprite2D
@export var speed = 300.0
@export_range (0, 1) var acceleration = 0.1
@export_range(0, 1) var deceleration = 0.1
var player: Player
var direction: float = 0.0

func _on_process(_delta : float) -> void:
	pass


func _on_physics_process(_delta : float) -> void:
	direction = GameInputEvents.movement_input()

	if direction:
		character_body_2d.velocity.x = direction * speed
		
	character_body_2d.move_and_slide()
	
	
func _on_next_transitions() -> void:
	# Fall state
	if not character_body_2d.is_on_floor():
		transition.emit("Fall")
	
	# Idle state
	elif direction == 0:
		transition.emit("Idle")
	
	# Jump state
	elif GameInputEvents.jump_input():
		transition.emit("Jump")
		
	# Dash state
	elif GameInputEvents.dash_input():
		transition.emit("Dash")
	
	# Attack state
	elif GameInputEvents.attack_input():
		transition.emit("Attack")


func _on_enter() -> void:
	animated_sprite_2d.play("run")


func _on_exit() -> void:
	animated_sprite_2d.stop()
