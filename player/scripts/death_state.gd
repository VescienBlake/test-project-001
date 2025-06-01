extends NodeState
class_name Death


@export_range(0, 1000) var deceleration = 500
@export var character_body_2d: CharacterBody2D
@export var animated_sprite_2d: AnimatedSprite2D

func _on_process(_delta : float) -> void:
	character_body_2d.velocity.x = 0
	if Input.is_action_just_pressed("interact"):
		get_tree().reload_current_scene()


func _on_physics_process(_delta : float) -> void:
	GameInputEvents.apply_gravity(character_body_2d, _delta)
	character_body_2d.velocity.x = move_toward(character_body_2d.velocity.x, 0, deceleration * _delta)
	
	character_body_2d.move_and_slide()
	

func _on_next_transitions() -> void:
	pass


func _on_enter() -> void:
	animated_sprite_2d.play("death")
	

func _on_exit() -> void:
	animated_sprite_2d.stop()
