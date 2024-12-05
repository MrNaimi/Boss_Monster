extends Node2D


func _on_quit_button_pressed() -> void:
	get_tree().quit()

func _on_retry_button_pressed() -> void:
	GlobalVariables.reset_defaults()
	Transition.change_scene("res://Scenes/Main_menu/main_menu.tscn")
