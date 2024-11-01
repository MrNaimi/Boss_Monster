extends Node2D
@onready var health_bar: ProgressBar = $healthBar
@onready var idle_animation: AnimatedSprite2D = $Idle_animation
@onready var timer: Timer = $Timer
var hp = GlobalVariables.heroHp
@onready var hpNext = RandomNumberGenerator.new().randi_range(10,15)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health_bar.max_value = hp


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if GlobalVariables.hero_progress > 850 and GlobalVariables.hero_progress < 1850:
		idle_animation.flip_h = true
	else:
		idle_animation.flip_h = false
		
	timer.wait_time = GlobalVariables.timerAmount
	health_bar.value = hp
	print(hp)
	
	if hp <= 0:
		queue_free()
		GlobalVariables.heroHp = hpNext
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
