extends Node2D
@onready var health_bar: ProgressBar = $healthBar

@onready var idle_animation: AnimatedSprite2D = $Idle_animation
@onready var timer: Timer = $Timer
var hp = GlobalVariables.heroHp


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if GlobalVariables.hero_progress > 950 and GlobalVariables.hero_progress < 1850:
		idle_animation.flip_h = true
	else:
		idle_animation.flip_h = false
		
	timer.wait_time = GlobalVariables.timerAmount
	health_bar.value = hp
	print(hp)
	
	if hp <= 0:
		queue_free()
		hp = GlobalVariables.heroHp
		GlobalVariables.heroKilled = true
		
	

func _on_hit_box_area_entered(area: Area2D) -> void:
	GlobalVariables.heroes_move=false
	if GlobalVariables.autoplay:
		timer.start()
	
	
func _on_timer_timeout() -> void:
	GlobalVariables.heroes_move=true


func _on_hit_box_area_exited(area: Area2D) -> void:
	hp -= GlobalVariables.damageGiven
	GlobalVariables.heroHp = hp
