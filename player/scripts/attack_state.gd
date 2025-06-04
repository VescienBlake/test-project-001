extends NodeState

@export var character_body_2d: CharacterBody2D
@export var animation_player: AnimationPlayer
@export var attacking = false
@export var can_combo = false


func _on_process(_delta : float) -> void:
	pass
		
		
func _on_physics_process(_delta : float) -> void:
	pass


func _on_next_transitions() -> void:
	if GameInputEvents.attack_input() and can_combo == true and attacking == false:
		transition.emit("Attack2")
		
	elif character_body_2d.is_on_floor() and can_combo == false:
		transition.emit("Idle")
	
	elif not character_body_2d.is_on_floor() and can_combo == false:
		transition.emit("Fall")


func _on_enter() -> void:
	attacking = true
	animation_player.play("attack_up")
	combo_timer()

func _on_exit() -> void:
	animation_player.stop()
	

func combo_timer():
	can_combo = true
	await get_tree().create_timer(0.7).timeout
	can_combo = false
	
	
