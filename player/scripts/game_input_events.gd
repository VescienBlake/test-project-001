class_name GameInputEvents
extends Node


static func apply_gravity(body: CharacterBody2D, delta: float, gravity: float = 900):
	body.velocity.y += gravity * delta
	
static func movement_input() -> float:
	var direction: float = Input.get_axis("move_left", "move_right")
	return direction
	
static func jump_input() -> bool:
	var jump: bool = Input.is_action_just_pressed("jump")
	return jump
	
static func attack_input() -> bool:
	var attack: bool = Input.is_action_just_pressed("attack")
	return attack

static func dash_input() -> bool:
	var dash: bool = Input.is_action_just_pressed("dash")
	return dash
	
