extends Node2D

@onready var path_follow_2d: PathFollow2D = $Path2D/PathFollow2D
@export var speed = 100
@onready var idle_animation: AnimatedSprite2D = $Path2D/PathFollow2D/Idle_animation


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#idle_animation.flip_h = true
	path_follow_2d.progress += speed * delta
	#print()
	if path_follow_2d.progress > 950 or path_follow_2d.progress < 1750:
		print(path_follow_2d.progress)
		#idle_animation.flip_h = true
	#else:
		#idle_animation.flip_h = false
#
		#
	#
