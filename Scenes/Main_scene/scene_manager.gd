extends Node

@export var food_scene: PackedScene
@onready var food_container: Node2D = %food_container


func _ready() -> void:
	GameManager.current_food_container = GameManager.max_food_container


func _process(delta: float) -> void:
	# esto se tiene que eliminar antes de subir el juego
	if Input.is_action_just_pressed("Close_Game"):
		get_tree().quit()


func _on_feed_dolphins_button_pressed() -> void:
	if GameManager.current_food_container <= 0:
		print("no hay comida para delfines")
		return
		
	GameManager.current_food_container-= 1
	_spawn_food()

func _spawn_food()->void:
	var food = food_scene.instantiate()
	food.position = food_container.position
	food.position.x = randf_range(-300,300)
	food.position.y -= 200
	food_container.add_child(food)
	
	
