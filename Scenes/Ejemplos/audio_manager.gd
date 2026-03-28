extends Node
class_name AudioManager


@onready var money_get_it: AudioStreamPlayer = $"../Money_get_it"


func _ready() -> void:
	GameManager.money_changed.connect(_on_money_changed)
	

func _on_money_changed()->void:
	money_get_it.play()
