extends Camera2D


@export var max_shake:= 1.0
@export var shake_fade:= 6.0

var _shake_strenght:= 0.0

func trigger_shake() -> void:
	_shake_strenght = max_shake
	
	
func _process(delta: float) -> void:
	if _shake_strenght > 0:
		_shake_strenght = lerp(_shake_strenght, 0.0, shake_fade * delta)
		offset = Vector2(randf_range(-_shake_strenght, _shake_strenght), randf_range(-_shake_strenght, _shake_strenght))
