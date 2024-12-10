extends AudioStreamPlayer2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
		if GlobalVariables.play_trap_sound:	
			stream = load("res://Assets/Sound Effects/"+GlobalVariables.soundpath)
			play()
			GlobalVariables.play_trap_sound = false
