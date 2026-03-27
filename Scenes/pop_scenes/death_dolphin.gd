extends CharacterBody2D
class_name death_dolphin

@export var gravity  = 300
var gravity_dir = Vector2.DOWN

@export var quality_food :float = 30



func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += gravity_dir * gravity * delta
	move_and_slide()
