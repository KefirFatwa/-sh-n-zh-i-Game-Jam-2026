extends Control
class_name CocinaManager


@export var minijuego : Array[PackedScene]= []
var hay_juego_activo : bool = false

@onready var chicken_button: Button = %Chicken_button
@onready var noddle_button: Button = %noddle_button
@onready var tacos_button: Button = %Tacos_button

@onready var alerta_cocina: TextureRect = %AlertaCocina
@onready var cocina_active: AudioStreamPlayer = %Cocina_active

@onready var cocina: CocinaManager = %Cocina

func _ready() -> void:
	GameManager.pollo_actualizado.connect(_actualizar_texto_cantidad_pollo)

func _process(delta: float) -> void:
	if hay_juego_activo:
		alerta_cocina.visible = true
	else:
		alerta_cocina.visible = false

func _actualizar_texto_cantidad_pollo(cantidad_pollo)->void:
	chicken_button.text = "x" + str(cantidad_pollo)



func _on_chicken_button_pressed() -> void:
	_spawn_minigame(minijuego[0])
	
func _on_noddle_button_pressed() -> void:
	_spawn_minigame(minijuego[1])
	
func _on_tacos_button_pressed() -> void:
	_spawn_minigame(minijuego[2])

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
