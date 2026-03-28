extends Control
class_name CocinaManager


@export var minijuego : Array[PackedScene]= []


@onready var chicken_button: Button = %Chicken_button
@onready var noddle_button: Button = %noddle_button
@onready var tacos_button: Button = %Tacos_button


@onready var cocina: CocinaManager = %Cocina


func _on_chicken_button_pressed() -> void:
	_spawn_minigame(minijuego[0])
func _on_noddle_button_pressed() -> void:
	_spawn_minigame(minijuego[1])
func _on_tacos_button_pressed() -> void:
	_spawn_minigame(minijuego[2])

func _spawn_minigame(mini_game : PackedScene)->void:
	var game = mini_game.instantiate()
	game.position = cocina.position
	cocina.add_child(game)
