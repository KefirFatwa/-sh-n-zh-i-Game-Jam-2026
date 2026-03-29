extends Node

@onready var historia_container = %HistoriaContainer
@onready var tutorial_container = %TutorialContainer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	tutorial_container.hide()
	historia_container.show()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_window_close_requested() -> void:
	queue_free()

func _on_continuar_pressed() -> void:
	historia_container.hide()
	tutorial_container.show()

func _on_jugar_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Ejemplos/Main_scene.tscn")
