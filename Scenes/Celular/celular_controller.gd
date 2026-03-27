extends Node

@onready var celularScene = preload("res://Scenes/Celular/celular_scene.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var celular = celularScene.instantiate()
	add_child(celular)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
