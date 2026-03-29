extends Node
class_name FoodManager

@onready var eat_range: Area2D = %EatRange
@export var general_status: GeneralManager

func _ready():
	eat_range.body_entered.connect(_on_food_entered)

func _on_food_entered(body: Fishfood) -> void:
	if general_status.current_food >= 160:
		return

	general_status.add_food(body.quality_food)
	body.queue_free()
