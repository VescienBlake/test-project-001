extends NodeState

@onready var state_machine: NodeStateMachine = $".."
@export var character_body_2d: CharacterBody2D
@export var animated_sprite_2d: AnimatedSprite2D



func _on_process(_delta : float) -> void:
	pass
		
		
func _on_physics_process(_delta : float) -> void:
	character_body_2d.velocity.x = 0
	
	
func _on_next_transitions() -> void:
	var direction = GameInputEvents.movement_input()
	
	# Fall state
	if not character_body_2d.is_on_floor():
		transition.emit("Fall")
		
	# Run state
	elif direction and character_body_2d.is_on_floor():
		animated_sprite_2d.flip_h = false if direction > 0 else true
		transition.emit("Run")
	
	# Jump state
	elif GameInputEvents.jump_input():
		transition.emit("Jump")
		
	# Dash state
	elif GameInputEvents.dash_input() and DashCooldown.can_dash:
		transition.emit("Dash")
		
	# Attack state
	elif GameInputEvents.attack_input():
		transition.emit("Attack")
		

func _on_enter() -> void:
	animated_sprite_2d.play("idle")


func _on_exit() -> void:
	animated_sprite_2d.stop()
