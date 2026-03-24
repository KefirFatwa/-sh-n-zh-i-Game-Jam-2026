extends Node


func _process(delta: float) -> void:
	# esto se tiene que eliminar antes de subir el juego
	if Input.is_action_just_pressed("Close_Game"):
		get_tree().quit()
