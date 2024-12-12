extends Control

var boss_selection = preload("res://Scenes/Main_menu/boss_selection.tscn")
var Dungeon_Scene = preload("res://Scenes/Dungeon/Dungeon.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AudioStreamPlayer2D.play(0)
	$Menu/Play_Button.grab_focus()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _on_play_button_pressed() -> void:

	print("Play button was pressed")
	Transition.change_scene("res://Scenes/Main_menu/boss_selection.tscn")


func _on_quit_game_pressed() -> void:
	get_tree().quit()

func _on_collections_pressed() -> void:
	print("Collections button was pressed")
	Transition.change_scene("res://Scenes/Main_menu/collections.tscn")
