extends Node2D

var is_dragging = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Z-button"):
		
		
		print("Continue")

func _on_quit_game_pressed() -> void:
	get_tree().quit()


func _on_continue_button_pressed() -> void:
	print("Continue")
