extends Node
class_name LoveManager

@export var dolphin_character: DolphinBase 
var max_love = 100
var current_love

@export var lonelines_frequency = 1

var is_sad = false

func  _ready() -> void:
	current_love = max_love

func _process(delta: float) -> void:
	current_love -= lonelines_frequency * delta
	if current_love <= 30:
		is_sad = true
	else:
		is_sad = false


func _input(event: InputEvent) -> void:
	if dolphin_character.is_pettable:
		if event.is_action_pressed("interaction_left_click"):
			current_love += GameManager.love_per_hit
			current_love = clamp(current_love, 0 , max_love)
		
