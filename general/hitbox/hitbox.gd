class_name Hitbox
extends Area2D 

signal Damaged(damage: int)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func take_dmg(damage: int) -> void:
	print("Damage: ", damage)
	Damaged.emit(damage)
