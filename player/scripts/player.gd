class_name Player
extends CharacterBody2D

@export var animated_sprite_2d: AnimatedSprite2D
@onready var state_machine: NodeStateMachine = $StateMachine
@export var health = 3
@onready var hurtbox: Hurtbox = $Hurtbox


func _ready() -> void:
	pass


func _process(delta: float) -> void:
	var direction = GameInputEvents.movement_input()
	
	if direction:
		if direction > 0:
			hurtbox.scale.x = 1.0
			animated_sprite_2d.flip_h = false 
			animated_sprite_2d.offset.x = 0.0
		else:
			hurtbox.scale.x = -1.0
			animated_sprite_2d.flip_h = true
			animated_sprite_2d.offset.x = -16.0

			
	#if Input.is_action_just_pressed("attack"):
		#health = 0
		#
	#check_death()



func check_death():
	if health <= 0 and state_machine.current_node_state_name != "death":
		state_machine.transition_to("Death")
