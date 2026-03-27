extends Node
class_name LoveManager

@export var dolphin_character: DolphinBase
@export var general_status: GeneralManager

func _input(event: InputEvent) -> void:
	if dolphin_character.is_pettable:
		if event.is_action_pressed("interaction_left_click"):
			general_status.add_love(GameManager.love_per_hit)
