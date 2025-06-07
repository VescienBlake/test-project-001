class_name NPC
extends Node2D

@export var health: int = 3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Hitbox.Damaged.connect(take_dmg)


func take_dmg(damage: int) -> void:
	health -= damage
	if health <= 0:
		queue_free()
