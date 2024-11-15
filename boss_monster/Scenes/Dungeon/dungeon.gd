extends Node2D

var is_dragging = false
@onready var cards: Array[Node] = []
@onready var hand: Hand = $DungeonUI/Hand
@onready var card_drop_areas: Node2D = $CardDropAreas
@onready var path_follow_2d: PathFollow2D = $Heroes/Path2D/PathFollow2D
@onready var autoplay: Button = $Buttons/Autoplay
@onready var heroes: Node2D = $Heroes
@onready var hero: PackedScene = preload("res://hero.tscn")
@onready var boss_health_bar: ProgressBar = $Control/bossHealthBar
@onready var damage = 999
@onready var hp = 50
@onready var boss_hp: Label = $Control/BossHp
@onready var first_time_continue = true
@onready var current_phase_text: Label = $CurrentPhaseText

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(GlobalVariables.rooms)
	pass
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Z-button"):
		if GlobalVariables.rooms_placed.size()>0:
			if GlobalVariables.is_everyone_stopped() or first_time_continue:
				GlobalVariables.heroes_move = true
				print(GlobalVariables.spawned_heroes)
				for path in GlobalVariables.spawned_heroes:
					if is_instance_valid(path):
						path.get_child(0).can_move=true
			first_time_continue=false
		else:
			print("Place a room first")
			
	
func _on_quit_game_pressed() -> void:
	get_tree().quit()


func _on_continue_button_pressed() -> void:
	#print("Continue")
	if GlobalVariables.trap_placed:
		GlobalVariables.currentPhase="combat"
		if GlobalVariables.rooms_placed.size()>0:
			if GlobalVariables.is_everyone_stopped() or first_time_continue:
				GlobalVariables.heroes_move = true
				print(GlobalVariables.spawned_heroes)
				for path in GlobalVariables.spawned_heroes:
					if is_instance_valid(path):
						path.get_child(0).can_move=true
			first_time_continue=false
	else:
		print("Place a trap first!!!")

func _on_reset_button_pressed() -> void:
	#path_follow_2d.progress=0
	#get_tree().reload_current_scene()
	GlobalVariables.heroes_move=false
	GlobalVariables.autoplay=false
	autoplay.text="Autoplay Off"
	#hero.hp = 0
	for carddroparea in card_drop_areas.get_children():
		for room in carddroparea.get_children():
			for vboxcontainer in room.get_children():
				for card in vboxcontainer.get_children():
					if card.is_in_group("card"):
						card.reset()


func _on_autoplay_pressed() -> void:
	if GlobalVariables.trap_placed:
		GlobalVariables.currentPhase="combat"
		GlobalVariables.autoplay = !GlobalVariables.autoplay
		if GlobalVariables.autoplay:
			GlobalVariables.heroes_move=true
			for path in GlobalVariables.spawned_heroes:
				if is_instance_valid(path):
					path.get_child(0).can_move=true
			autoplay.text="Autoplay On"
		else:
			autoplay.text="Autoplay Off"
	else:
		print("Place a trap first!!!")

func _on_area_2d_area_entered(area: Area2D) -> void:
	#print(area.get_parent().get_parent().hp)
	hp -= area.get_parent().get_parent().hp
	area.get_parent().get_parent().hp=0
	boss_health_bar.value = hp
	boss_hp.text=str(hp)
	if GlobalVariables.autoplay:
		GlobalVariables.heroes_move=true
	#GlobalVariables.heroHp = RandomNumberGenerator.new().randi_range(10,15)

func refreshHP() -> void:
	boss_hp.text = str(hp)
	boss_health_bar.value = hp
