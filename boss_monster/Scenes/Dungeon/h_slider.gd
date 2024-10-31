extends HSlider

@onready var timer: Timer = $"../../Heroes/Path2D/Timer"




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	GlobalVariables.timerAmount = 1-value
	
