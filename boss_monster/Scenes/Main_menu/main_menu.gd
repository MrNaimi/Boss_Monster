extends Control


var Dungeon_Scene = preload("res://Scenes/Dungeon/Dungeon.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _on_play_button_pressed() -> void:
	
	print("Play button was pressed!!!!!")
	get_tree().change_scene_to_packed(Dungeon_Scene)


func _on_quit_game_pressed() -> void:
	get_tree().quit()

func _on_collections_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Main_menu/collections.tscn")
