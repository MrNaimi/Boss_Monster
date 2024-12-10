extends Node2D
@onready var health_bar: ProgressBar = $healthBar
@onready var idle_animation: AnimatedSprite2D = $Idle_animation
@onready var hp = 1
#@onready var hp = RandomNumberGenerator.new().randi_range(10,15)
var selectedHero = []
@onready var heroes: Array[Array] = GlobalVariables.heroes
@onready var can_move = true
@onready var path_direction = 1
@onready var flipped = false
@onready var mindcontrolled = false
@onready var hero_class: String
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalVariables.spawned_heroes.append(get_parent())
	GlobalVariables.amount_of_heroes_alive += 1
	#health_bar.max_value = hp
	var i =  RandomNumberGenerator.new().randi_range(0, heroes.size()-1)
	selectedHero=heroes[i]
	hp = round(RandomNumberGenerator.new().randi_range(selectedHero[2],selectedHero[3])*(0.5+0.25*GlobalVariables.infamy))
	health_bar.max_value = hp
	idle_animation.animation = selectedHero[4]
	hero_class=selectedHero[4]
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:		
	health_bar.value = hp
	#print(hp)
	
	if hp <= 0:
		if GlobalVariables.autoplay:
			GlobalVariables.heroes_move=true
		GlobalVariables.heroKilled = true
		get_parent().queue_free()
		GlobalVariables.amount_of_heroes_alive-=1
		GlobalVariables.amount_of_heroes_killed+=1
		GlobalVariables.player_gold+=round(RandomNumberGenerator.new().randi_range(2, 4)*(1+0.1*GlobalVariables.infamy))
	if get_parent().progress < 50:
		path_direction = 1
		flipped = false

func _on_hit_box_area_entered(area: Area2D) -> void:
	#GlobalVariables.heroes_move=false
	if area.get_parent().get_parent().name!="Hero" or area.get_parent().get_parent().mindcontrolled:
			can_move = false
			if GlobalVariables.autoplay:
				GlobalVariables.timerStart = true
			
			
func _on_hit_box_area_exited(area: Area2D) -> void:
	var damageTaken = area.get_parent().damage*selectedHero[1]
	#print("Exited trap damage: ",area.get_parent().damage)
	hp -= damageTaken
	if mindcontrolled:
		hp-=area.get_parent().get_parent().hp
		mindcontrolled = false
		flipped = false
	get_child(0).damage = 0
	#print(hp)
	

func isEveryoneStopped () -> bool:
	for path in GlobalVariables.spawned_heroes:
		if is_instance_valid(path):
			if path.get_child(0).can_move:
				return false
	return true
