class_name Player
extends CharacterBody2D


@onready var state_machine: NodeStateMachine = $StateMachine
@export var health = 3
var can_dash = false



func _ready() -> void:
	pass


func _process(delta: float) -> void:
	pass
	#if Input.is_action_just_pressed("attack"):
		#health = 0
		#
	#check_death()


func check_death():
	if health <= 0 and state_machine.current_node_state_name != "death":
		state_machine.transition_to("Death")


func dash_cooldown():
	can_dash = false
	await get_tree().create_timer(0.6).timeout
	can_dash = true
