extends NodeState

@export var character_body_2d: CharacterBody2D
@export var animation_player: AnimationPlayer
@export var attacking_2 = false


func _on_process(_delta : float) -> void:
	pass
		

func _on_physics_process(_delta : float) -> void:
	pass


func _on_next_transitions() -> void:
	if character_body_2d.is_on_floor() and attacking_2 == false:
		transition.emit("Idle")
	
	elif not character_body_2d.is_on_floor() and attacking_2 == false:
		transition.emit("Fall")


func _on_enter() -> void:
	attacking_2 = true
	animation_player.play("attack_down")
