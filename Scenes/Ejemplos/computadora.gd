extends Control

@onready var respuestas: Control = $PanelContainer/MarginContainer/VBoxContainer/Respuestas

var respuesta_correcta : bool = false
var puntos_global = 0

func _on_check_box_button_down() -> void:
	respuesta_correcta = true
	
func _process(delta: float) -> void:
	if respuesta_correcta == true:
		print("ganaste la trivia,", siguiente_pregunta())
		puntos_global +=1

func siguiente_pregunta():
	pass
