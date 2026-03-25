extends Control

@onready var pregunta: Label = $PanelContainer/MarginContainer/Preguntas/Label

@onready var check_box_1: CheckBox = $PanelContainer/MarginContainer/Preguntas/Respuesta_1/CheckBox
@onready var check_box_2: CheckBox = $PanelContainer/MarginContainer/Preguntas/Respuesta_2/CheckBox
@onready var check_box_3: CheckBox = $PanelContainer/MarginContainer/Preguntas/Respuesta_3/CheckBox
@onready var check_box_4: CheckBox = $PanelContainer/MarginContainer/Preguntas/Respuesta_4/CheckBox


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
