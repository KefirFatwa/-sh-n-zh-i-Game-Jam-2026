extends ColorRect
@onready var close_sound: AudioStreamPlayer = $close_sound
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_close_button_pressed() -> void:
	close_sound.play()
	queue_free()


func _on_texture_button_pressed() -> void:
	if GameManager.global_money >= 5:
		GameManager.global_money -= 5
	GameManager.money_changed.emit()
	animation_notification().play("stealMoney")
	queue_free()
	print("Perdiste plata")

func animation_notification()->AnimationPlayer:
	return get_tree().get_first_node_in_group("NotificationManager")
