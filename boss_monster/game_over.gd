extends Node2D


func _on_quit_button_pressed() -> void:
	get_tree().quit()

func _on_retry_button_pressed() -> void:
	Transition.change_scene("res://Scenes/Main_menu/main_menu.tscn")
