extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Main_menu/main_menu.tscn")



func _on_heroes_mouse_entered() -> void:
	$PaladinSprite.visibility_layer = 1


func _on_heroes_mouse_exited() -> void:
	$PaladinSprite.visibility_layer = 0
	

func _on_bosses_mouse_entered() -> void:
	$LichSprite.visibility_layer = 1


func _on_bosses_mouse_exited() -> void:
	$LichSprite.visibility_layer = 0
