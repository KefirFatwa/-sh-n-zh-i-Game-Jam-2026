extends Button


func _on_pressed() -> void:
	GameManager.reset_game_data()
	get_tree().change_scene_to_file("res://Scenes/Start_Menu/start_menu.tscn")
