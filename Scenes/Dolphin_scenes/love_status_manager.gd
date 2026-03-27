extends Node
class_name LoveManager

@export var dolphin_character: DolphinBase
@export var general_status: GeneralManager
@export var love_particles : PackedScene

var text_tween : Tween

func _input(event: InputEvent) -> void:
	if dolphin_character.is_pettable:
		if event.is_action_pressed("interaction_left_click"):
			general_status.add_love(GameManager.love_per_hit)
			_spawn_love()

func _spawn_love()->void:
	var love_pp = love_particles.instantiate()
	love_pp.position = get_parent().global_position
	var number = Label.new()
	number.text = str(GameManager.love_per_hit)
	number.position= get_parent().global_position
	number.scale = Vector2(2,2)
	
	text_tween= create_tween()
	
	text_tween.tween_property(number,"scale",Vector2(0,0),1)
	
	add_child(love_pp)
	add_child(number)
	get_tree().create_timer(2).timeout.connect(func():
		number.queue_free()
		)
	
func _delete_text(text:Label)->void:
	text.queue_free()
