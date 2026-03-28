extends Control
class_name CocinaManager


@export var minijuego : Array[PackedScene]= []
var hay_juego_activo : bool = false

@onready var chicken_button: Button = %chicken_button
@onready var noodle_button: Button = %noddle_button
@onready var tacos_button: Button = %tacos_button

@onready var alerta_cocina: TextureRect = %AlertaCocina
@onready var cocina_active: AudioStreamPlayer = %Cocina_active

@onready var cocina: CocinaManager = %Cocina

func _ready() -> void:
	GameManager.pollo_actualizado.connect(_actualizar_texto_cantidad_pollo)
	GameManager.maruchan_actualizado.connect(_actualizar_texto_cantidad_noodle)
	GameManager.taco_actualizado.connect(_actualizar_texto_cantidad_tacos)
	
	_actualizar_texto_cantidad_pollo(GameManager.pollo_cantidad)
	_actualizar_texto_cantidad_noodle(GameManager.maruchan_cantidad)
	_actualizar_texto_cantidad_tacos(GameManager.taco_cantidad)

func _process(delta: float) -> void:
	if hay_juego_activo:
		alerta_cocina.visible = true
	else:
		alerta_cocina.visible = false

func _actualizar_texto_cantidad_pollo(cantidad_pollo)->void:
	chicken_button.text = "x" + str(cantidad_pollo)



func _on_chicken_button_pressed() -> void:
	if GameManager.pollo_cantidad > 0:
		_spawn_minigame(minijuego[0])
		GameManager.remove_food_pollo(1)
	else: print("No tienes para cocinar")
	
func _on_noddle_button_pressed() -> void:
	if GameManager.maruchan_cantidad > 0:
		_spawn_minigame(minijuego[1])
		GameManager.remove_food_maruchan(1)
	else: print("No tienes para cocinar")
	
func _on_tacos_button_pressed() -> void:
	if GameManager.taco_cantidad > 0:
		_spawn_minigame(minijuego[2])
		GameManager.remove_food_tacos(1)
	else: print("No tienes para cocinar")

func _spawn_minigame(mini_game : PackedScene)->void:
	if hay_juego_activo:
		return
	
	hay_juego_activo = true 
	var game = mini_game.instantiate()
	
	game.tree_exited.connect(_on_minigame_exited)
	game.position = cocina.position
	cocina_active.play()
	cocina.add_child(game)
	
func _on_minigame_exited():
	hay_juego_activo = false
