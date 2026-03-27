extends CharacterBody2D
class_name Fishfood


@export var gravity  = 300
var gravity_dir = Vector2.DOWN

@export var quality_food :float = 30

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var timer: Timer = $Timer

func _ready() -> void:
	get_tree().create_timer(2).timeout.connect(timer.start)


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += gravity_dir * gravity * delta
	move_and_slide()


func _on_timer_timeout() -> void:
	collision_shape_2d.disabled = !collision_shape_2d.disabled
