extends Node2D

var is_dragging = false
@onready var cards: Array[Node] = []
@onready var hand: Hand = $DungeonUI/Hand
@onready var card_drop_areas: Node2D = $CardDropAreas
@onready var path_follow_2d: PathFollow2D = $Heroes/Path2D/PathFollow2D
@onready var autoplay: Button = $PauseMenu/MarginContainer/VBoxContainer/Autoplay
@onready var heroes: Node2D = $Heroes
@onready var hero: PackedScene = preload("res://hero.tscn")
@onready var boss_health_bar: ProgressBar = $Control/bossHealthBar
@onready var damage = 999
@onready var hp = 50
@onready var boss_hp: Label = $Control/BossHp
@onready var first_time_continue = true
@onready var current_phase_text: Label = $CurrentPhaseText
@onready var info: Label = $card_info/ColorRect/info
@onready var card_info: Control = $card_info
@onready var trap_sound: AudioStreamPlayer2D = $trap_sound
@onready var pause_menu: Control = $PauseMenu
@onready var town_camera: Camera2D = $TownCamera
@onready var default_camera: Camera2D = $DefaultCamera
@onready var dungeon_ui: CanvasLayer = $DungeonUI
var visibility_changeable = true


var paused = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AudioStreamPlayer2D.play(0)
	print(GlobalVariables.rooms)
	default_camera.make_current()
	pass
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if GlobalVariables.infamy % 10 == 0 and visibility_changeable:
		default_camera.set_enabled(false)
		print("town scene pitäis olla")
		town_camera.set_enabled(true)
		town_camera.make_current()
		dungeon_ui.hide()
		visibility_changeable = false
		GlobalVariables.show = false
		GlobalVariables.town_music = true
	
		
	if GlobalVariables.infamy % 10 == 1:
		visibility_changeable = true
		pass
	
	if GlobalVariables.show:
		dungeon_ui.show()
		
	if Input.is_action_just_pressed("pause"):
		pauseMenu()
	
	#if Input.is_action_just_pressed("spacebar"):
		#continueButton()
		#
	
	if GlobalVariables.room_cards_created.size()>0:
		if GlobalVariables.is_everyone_stopped() or first_time_continue:
			GlobalVariables.heroes_move = true
			#print(GlobalVariables.spawned_heroes)
			#for path ins GlobalVariables.spawned_heroes:
				#if path.is_instance_valid():
					#path.get_child(0).can_move=true
		first_time_continue=false
	else:
		pass
		#print("Place a room first")
	if hp<=0:
		queue_free()
		Transition.change_scene("res://Scenes/Dungeon/game_over.tscn")


		
func _on_quit_game_pressed() -> void:
	get_tree().quit()


func _on_continue_button_pressed() -> void:
	continueButton()
	
func continueButton() -> void:
	var length = 0
	if GlobalVariables.trap_placed:
		if GlobalVariables.currentPhase=="build":
			GlobalVariables.playshopanim = true
		GlobalVariables.printDmgBuffs()
		GlobalVariables.currentPhase="combat"
		if !GlobalVariables.values_changed:
			if GlobalVariables.stinky_ghouls>0 && GlobalVariables.misunderstood_ghosts>0 && GlobalVariables.shadows > 0 && !GlobalVariables.shadow_buff_given:
				GlobalVariables.UndeadDmgBuff+=5
				GlobalVariables.shadow_buff_given = true
			GlobalVariables.gatorDmgBuff-=1
			GlobalVariables.skeleton_ceo_activated = false
			for room in GlobalVariables.rooms_placed:
				if is_instance_valid(room):
					room.trap_activated = false
			for wolf in GlobalVariables.wolves_placed:
				wolf.card_ui.wolf_counter+=1
				GlobalVariables.round_counter += 1
			if GlobalVariables.lions_dens_in_the_dungeon>0:
				GlobalVariables.BeastDmgBuff+=GlobalVariables.beast_rooms_in_dungeon
			if GlobalVariables.outlaws_in_dungeon>0:
				GlobalVariables.player_gold-=2*GlobalVariables.outlaws_in_dungeon
				for outlaw in GlobalVariables.outlaws:
					if is_instance_valid(outlaw):
						outlaw.card_ui.room_dmg_2.text = "-2"
						outlaw.card_ui.paskahuussi.play("money_animation")
					else:
						GlobalVariables.remove_child(outlaw)
				#GlobalVariables.outlaw_animation = true
			if GlobalVariables.orc_bodyguards_in_dungeon>0:
				GlobalVariables.player_gold-=3*GlobalVariables.orc_bodyguards_in_dungeon
				for bodyguard in GlobalVariables.orc_bodyguards:
					if is_instance_valid(bodyguard):
						print(bodyguard.name)
						bodyguard.card_ui.room_dmg_2.text = "-3"
						bodyguard.card_ui.paskahuussi.play("money_animation")
					else:
						GlobalVariables.remove_child(bodyguard)
				#GlobalVariables.orc_bodyguard_animation = true
			GlobalVariables.values_changed = true
		if GlobalVariables.rooms_placed.size()>0:
			if GlobalVariables.is_everyone_stopped() or first_time_continue:
				GlobalVariables.heroes_move = true
				print(GlobalVariables.spawned_heroes)
				for path in GlobalVariables.spawned_heroes:
					if is_instance_valid(path):
						path.get_child(0).can_move=true
					else:
						length += 1
				if length == 2 and GlobalVariables.amount_of_heroes_alive ==0:
					GlobalVariables.spawn_hero=true 
					GlobalVariables.heroKilled=true
							
			first_time_continue=false
	else:
		GlobalVariables.message("Place a trap first!!!",false)

func _on_reset_button_pressed() -> void:
	if GlobalVariables.currentPhase=="build":
		GlobalVariables.resetValues(false)
		for card in GlobalVariables.room_cards_created:
			if is_instance_valid(card):
				card.initializeCard()

	
func _on_autoplay_pressed() -> void:
	GlobalVariables.autoplay = !GlobalVariables.autoplay
	if GlobalVariables.autoplay:
		autoplay.text="Autoplay On"
		if GlobalVariables.is_everyone_stopped():
			for path in GlobalVariables.spawned_heroes:
				if is_instance_valid(path):
					path.get_child(0).can_move=true
	else:
		autoplay.text="Autoplay Off"


func _on_area_2d_area_entered(area: Area2D) -> void:
	#print(area.get_parent().get_parent().hp)
	print("Boss took ",area.get_parent().get_parent().hp," damage")
	hp -= area.get_parent().get_parent().hp
	
	print("JOUUUUUUUUUUUU")
	
	area.get_parent().get_parent().hp=0
	boss_health_bar.value = hp
	boss_hp.text=str(hp)
	if GlobalVariables.autoplay:
		GlobalVariables.heroes_move=true
	#GlobalVariables.heroHp = RandomNumberGenerator.new().randi_range(10,15)

func refreshHP() -> void:
	boss_hp.text = str(hp)
	boss_health_bar.value = hp

func pauseMenu() -> void:
	if paused:
		for button in get_tree().get_nodes_in_group("button"):
			button.disabled = false
		pause_menu.hide()
		#get_tree().paused = false
		Engine.time_scale = 1
		print("peba")
	else:
		for button in get_tree().get_nodes_in_group("button"):
			button.disabled = true
		print("paba")
		pause_menu.show()
		#get_tree().paused = true
		Engine.time_scale = 0
	
	GlobalVariables.paused = not GlobalVariables.paused
	paused = not paused


func _on_resume_pressed() -> void:
	pauseMenu()


func _on_button_pressed() -> void:
	GlobalVariables.actionsLeft+=1


func _on_cheat_1_pressed() -> void:
	GlobalVariables.infamy = 10


func _on_cheat_pressed() -> void:
	GlobalVariables.infamy = 20


func _on_infamy_11_pressed() -> void:
	GlobalVariables.infamy = 11
