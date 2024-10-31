extends HSlider

@onready var timer: Timer = $"../../Hero/Path2D/Timer"



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	timer.wait_time=1-value
	
