extends Node2D

@onready var path_follow_2d: PathFollow2D = $Path2D/PathFollow2D
@export var speed = 500
@onready var idle_animation: AnimatedSprite2D = $Path2D/PathFollow2D/Idle_animation
@onready var timer: Timer = $Path2D/Timer
@export var hp = 10
@export var dmg = 5

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#idle_animation.flip_h = true
	if GlobalVariables.heroes_move && GlobalVariables.combat_phase:
		path_follow_2d.progress += speed * delta
		if path_follow_2d.progress > 950 and path_follow_2d.progress < 1850:
			idle_animation.flip_h = true
		else:
			idle_animation.flip_h = false


func _on_hit_box_area_entered(area: Area2D) -> void:
	GlobalVariables.heroes_move=false
	if GlobalVariables.autoplay:
		timer.start()
	
func _on_timer_timeout() -> void:
	GlobalVariables.heroes_move=true
