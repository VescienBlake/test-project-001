class_name Player
extends CharacterBody2D


@onready var state_machine: NodeStateMachine = $StateMachine
@export var health = 3


func _ready() -> void:
	pass


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("attack"):
		health = 0
		
	check_death()


func check_death():
	if health <= 0 and state_machine.current_node_state_name != "death":
		state_machine.transition_to("Death")
