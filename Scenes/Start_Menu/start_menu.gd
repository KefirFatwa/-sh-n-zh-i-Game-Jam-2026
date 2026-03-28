extends Node

@onready var opcionesScene = preload("res://Scenes/Start_Menu/Opciones/opciones.tscn")
@onready var creditosScene = preload("res://Scenes/Start_Menu/Creditos/creditos.tscn")
@onready var tutorialScene = preload("res://Scenes/Start_Menu/Tutorial/tutorial_popup.tscn")
@onready var button_press_sound: AudioStreamPlayer = $Button_press_sound

var opciones = null
var creditos = null
var tutorial = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_jugar_pressed() -> void:
	button_press_sound.play()
	if GameManager.tutorial_activo:
		if tutorial == null:
			tutorial = tutorialScene.instantiate()
			add_child(tutorial)
	else:
		get_tree().change_scene_to_file("res://Scenes/Ejemplos/Main_scene.tscn")


func _on_opciones_pressed() -> void:
	button_press_sound.play()
	if opciones == null:
		opciones = opcionesScene.instantiate()
		add_child(opciones)


func _on_creditos_pressed() -> void:
	button_press_sound.play()
	if creditos == null:
		creditos = creditosScene.instantiate()
		add_child(creditos)


func _on_salir_pressed() -> void:
	button_press_sound.play()
	get_tree().quit()
