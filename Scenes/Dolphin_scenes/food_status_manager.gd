extends Node
class_name FoodManager

@onready var eat_range: Area2D = %EatRange
@export var general_status : GeneralManager

@export var hungry_range :float = 10

var was_alive :bool = true
func _ready() -> void:
	eat_range.body_entered.connect(_on_food_entered)
	

func _process(delta: float) -> void:
	general_status.current_food -= hungry_range * delta
	general_status.current_food = clamp(general_status.current_food,0,general_status.max_food)

	if general_status.current_food == 0:
		if was_alive:
			general_status.start_death_state.emit()
			was_alive = false
		general_status.is_hungry = false
	elif general_status.current_food < 30:
		general_status.is_hungry = true
	else:
		general_status.is_hungry = false
		was_alive = true

func _on_food_entered(body: Fishfood)->void:
	if general_status.current_food >= 60:
		return
	
	general_status.current_food += body.quality_food
	general_status.current_food= clamp(general_status.current_food, 0, general_status.max_food)
	body.queue_free()
