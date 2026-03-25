extends Node
class_name HealthComponent

var maxHealth : int 
var current_health : int
signal updated_health (current_health : int)
signal is_death
@export var target_object: GeneralData 

func _ready() -> void:
	maxHealth = target_object.max_health_object
	current_health = maxHealth 

func add_health(value)->void:
	maxHealth += value
	current_health = clamp(current_health, 0, maxHealth)
	updated_health.emit(current_health)

func decrease_health(value)->void:
	if is_dead():
		return
	current_health -= value
	current_health = max(current_health, 0)
	
	updated_health.emit(current_health)
	if is_dead():
		
		is_death.emit()
func is_dead()->bool:
	return current_health <= 0
