extends Node2D
@onready var health_bar: ProgressBar = $healthBar
@onready var idle_animation: AnimatedSprite2D = $Idle_animation
@onready var timer: Timer = $Timer
@onready var hp = 1
#@onready var hp = RandomNumberGenerator.new().randi_range(10,15)
var selectedHero = []
@onready var heroes: Array[Array] = GlobalVariables.heroes

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	#health_bar.max_value = hp
	var i =  RandomNumberGenerator.new().randi_range(0, heroes.size()-1)
	selectedHero=heroes[i]
	hp = RandomNumberGenerator.new().randi_range(selectedHero[2],selectedHero[3])
	health_bar.max_value = hp
	idle_animation.animation = selectedHero[4]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:		
	timer.wait_time = GlobalVariables.timerAmount
	health_bar.value = hp
	#print(hp)
	
	if hp <= 0:
		if GlobalVariables.autoplay:
			GlobalVariables.heroes_move=true
		GlobalVariables.heroKilled = true
		queue_free()
		
	

func _on_hit_box_area_entered(area: Area2D) -> void:
	GlobalVariables.heroes_move=false
	if GlobalVariables.autoplay:
		timer.start()
	
	
func _on_timer_timeout() -> void:
	GlobalVariables.heroes_move=true


func _on_hit_box_area_exited(area: Area2D) -> void:
	var damageTaken = area.get_parent().damage*selectedHero[1]
	#print("Exited trap damage: ",area.get_parent().damage)
	hp -= damageTaken
	#print(hp)
