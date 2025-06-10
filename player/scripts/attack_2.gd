extends NodeState

@export var character_body_2d: CharacterBody2D
@export var animation_player: AnimationPlayer
@export var attacking_2 = false
@onready var hurtbox: Hurtbox = $"../../Hurtbox"
@export var speed:= 200

func _on_process(_delta : float) -> void:
	pass
		

func _on_physics_process(_delta : float) -> void:
	GameInputEvents.apply_gravity(character_body_2d, _delta)
	
	# Character movement when attacking
	if character_body_2d.is_on_floor():
		character_body_2d.velocity.x = 0
	else:
		character_body_2d.velocity.x = GameInputEvents.movement_input() * speed
	
	# Controls hurtbox
	if attacking_2:
		hurtbox.visible = true
	else:
		hurtbox.monitoring = false
		hurtbox.visible = false

	character_body_2d.move_and_slide()
	
	
func _on_next_transitions() -> void:
	if GameInputEvents.attack_input() and attacking_2 == false:
		transition.emit("Attack")
		
	elif character_body_2d.is_on_floor() and attacking_2 == false:
		transition.emit("Idle")
	
	elif not character_body_2d.is_on_floor() and attacking_2 == false:
		transition.emit("Fall")


func _on_enter() -> void:
	hurtbox.monitoring = true
	attacking_2 = true
	animation_player.play("attack_down")
