extends Node

var can_dash = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func dash_cooldown():
	can_dash = false
	await get_tree().create_timer(0.6).timeout
	can_dash = true
