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
@onready var info: Label = $card_info/ColorRect/info
@onready var card_info: Control = $card_info
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(GlobalVariables.rooms)
	pass
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
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
	#print("Continue")

	var length = 0
	if GlobalVariables.trap_placed:
		if GlobalVariables.currentPhase=="build":
			GlobalVariables.playshopanim = true
		GlobalVariables.printDmgBuffs()
		GlobalVariables.currentPhase="combat"
		if !GlobalVariables.values_changed:
			if GlobalVariables.pack_of_wolves_placed>0:
				print("LISÄTÄÄN ROUND COUNTERIIN YKSI", GlobalVariables.round_counter)
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
	if GlobalVariables.trap_placed:
		GlobalVariables.currentPhase="combat"
		GlobalVariables.autoplay = !GlobalVariables.autoplay
		if GlobalVariables.autoplay:
			autoplay.text="Autoplay On"
			if GlobalVariables.is_everyone_stopped():
				for path in GlobalVariables.spawned_heroes:
					if is_instance_valid(path):
						path.get_child(0).can_move=true
		else:
			autoplay.text="Autoplay Off"
	else:
		print("Place a trap first!!!")

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
