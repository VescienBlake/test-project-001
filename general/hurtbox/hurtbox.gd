class_name Hurtbox
extends Area2D


@export var damage: int = 1
@onready var camera: Camera2D = get_tree().get_first_node_in_group("Camera")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	area_entered.connect(AreaEntered)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func AreaEntered(area: Area2D) -> void:
	if area is Hitbox:
		Hitstop.hitstop_short()
		camera.trigger_shake()
		area.take_dmg(damage)
