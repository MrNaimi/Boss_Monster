class_name CardUI
extends Control

signal reparent_requested(which_card_ui: CardUI)
signal reset_card()

@onready var card: PackedScene = preload("res://Cards/card_ui.tscn")
@onready var color: ColorRect = $ColorRect
@onready var state: Label = $State
@onready var card_state_machine: CardStateMachine = $CardStateMachine as CardStateMachine
@onready var drop_point_detecor: Area2D = $DropPointDetecor
@onready var targets: Array[Node] = []
@onready var trap_texture: Sprite2D = $trap_texture
@onready var trap_hit_box: CollisionShape2D = $HitBox/TrapHitBox
@onready var texturepath:= 'res://Cards/Graphics/trap_graphic/'
@onready var card_texture: Sprite2D = $CardTexture
@onready var card_border: Sprite2D = $CardBorder
@onready var rooms: Array[Array] = GlobalVariables.rooms
@onready var spells: Array[Array] = GlobalVariables.spells
@onready var room_type: Label = $Control/RoomType
@onready var room_dmg: Label = $Control/RoomDmg
@onready var card_name: Label = $Control/CardName
@onready var damage = int(room_dmg.text)
@onready var spawn_room = false
@onready var trap_enter: AudioStreamPlayer2D = $trap_enter
@onready var shop_card = false
@onready var card_info = ""
@onready var tribe = "spell"
@onready var selectedRoom = []
@onready var placed = false
@onready var room_dmg_2: Label = $Control/RoomDmg2
@onready var perseajastin: Timer = $perseajastin
@onready var paskahuussi: AnimationPlayer = $paskahuussi
@onready var activate_button: Button = $ActivateButton
@onready var trap_activated = false
@onready var entered_hero = null
@onready var trap_sound: AudioStreamPlayer2D = $trap_sound


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	initializeCard()
	GlobalVariables.room_cards_created.append(self)
	
func _process(delta: float) -> void:
	if !visible:
		queue_free()
	else:
		pass
	if placed:
		if card_name.text=="Outlaw" && GlobalVariables.currentPhase=="combat" && GlobalVariables.player_gold<0:
			GlobalVariables.outlaws_in_dungeon -= 1
			GlobalVariables.message("Your Outlaw has left the dungeon due to a lack of funds",false)
			visible = false
			GlobalVariables.spawn_room_set = false
		if card_name.text=="Killer Robot" && GlobalVariables.killer_robot_terminate:
			GlobalVariables.killer_robot_terminate = false
			GlobalVariables.message("Your killer robot has self destructed",false)
			visible = false
			GlobalVariables.spawn_room_set = false
		if card_name.text=="Orc Bodyguard" && GlobalVariables.currentPhase=="combat" && GlobalVariables.player_gold<0:
			GlobalVariables.orc_bodyguards_in_dungeon -= 1
			GlobalVariables.message("Your Orc Bodyguard has left the dungeon due to a lack of funds",false)
			visible = false
			GlobalVariables.spawn_room_set = false
		if card_name.text=="Pack of Wolves" && GlobalVariables.currentPhase=="build" && GlobalVariables.round_counter>=5:
			GlobalVariables.message("Your Pack of Wolves starved to death",false)
			GlobalVariables.pack_of_wolves_placed -= 1
			GlobalVariables.round_counter = 0
			visible = false
			GlobalVariables.spawn_room_set = false
		if GlobalVariables.goblin_army_animation && card_name.text=="Goblin Army":
			GlobalVariables.goblin_army_animation = false
			room_dmg_2.text = "+2"
			paskahuussi.play("money_animation")
		if GlobalVariables.goblin_warrior_animation && card_name.text=="Goblin Warrior":
			GlobalVariables.goblin_warrior_animation = false
			room_dmg_2.text = "+2"
			paskahuussi.play("money_animation")

func _input(event: InputEvent) -> void:
	card_state_machine.on_input(event)
	
func _on_gui_input(event: InputEvent) -> void:
	card_state_machine.on_gui_input(event)
	
func _on_mouse_entered() -> void:
	card_state_machine.on_mouse_entered()
	
func _on_mouse_exited() -> void:
	card_state_machine.on_mouse_exited()


func _on_drop_point_detecor_area_entered(area: Area2D) -> void:
	if not targets.has(area):
		targets.append(area)


func _on_drop_point_detecor_area_exited(area: Area2D) -> void:
	targets.erase(area)

func reset() -> void:
	reset_card.emit()
	


func _on_hit_box_area_entered(area: Area2D) -> void:
	#if !trap_enter.is_playing():
		#trap_enter.play()
	if !GlobalVariables.spawn_room_set:
		print("Current room set as the spawn room")
		spawn_room=true
		GlobalVariables.spawn_room_set = true
	if tribe == "trap" && !trap_activated:
		activate_button.visible = true
		entered_hero=area

func _on_hit_box_area_exited(area: Area2D) -> void:
	#if self in GlobalVariables.spawn_room:
	if spawn_room:
		GlobalVariables.spawn_hero=true
	activate_button.visible = false
	pass
	
func initializeCard() -> void:
	if get_parent().get_parent().get_parent().name == "ShopUI":
		shop_card=true
	rooms = GlobalVariables.rooms
	spells = GlobalVariables.spells
		#if GlobalVariables.spawn_room.size()==0:
	#	GlobalVariables.spawn_room.append(self) 
	var i =  RandomNumberGenerator.new().randi_range(0, rooms.size()-1)
	if !GlobalVariables.cardBought:
		selectedRoom=rooms.pop_at(i)
	else: 
		selectedRoom = GlobalVariables.cardData
		GlobalVariables.cardBought = false
	i =  RandomNumberGenerator.new().randi_range(0, spells.size()-1)
	var selectedSpell=spells.pop_at(i)
	card_state_machine.init(self)
	if GlobalVariables.created_spells < GlobalVariables.spell_limit:
		GlobalVariables.created_spells+=1
		print("Yritetään luoda spelliä")
		trap_texture.texture=load(texturepath+selectedSpell[5])
		card_texture.texture=load(texturepath+selectedSpell[5])
		card_name.text = selectedSpell[3]
		room_type.text = selectedSpell[0][0]
		room_dmg.text = str(selectedSpell[1])
		card_info = (selectedSpell[4])
		damage = int(room_dmg.text)
		card_border.texture=load("res://Cards/Graphics/spellcard.png")
		drop_point_detecor.set_collision_mask_value(3, false)
		drop_point_detecor.set_collision_mask_value(4, true)
		drop_point_detecor.set_collision_layer_value(3, false)
		
		pass
		
	else:
		if selectedRoom != null:
			trap_texture.texture=load(texturepath+selectedRoom[5])
			card_texture.texture=load(texturepath+selectedRoom[5])
			card_name.text = selectedRoom[2]
			room_type.text = selectedRoom[3][0]
			room_dmg.text = str(selectedRoom[1]+floor(0.10*GlobalVariables.infamy))
			damage = int(room_dmg.text)
			card_info = (selectedRoom[4])
			tribe = selectedRoom[7]
			trap_sound.stream = load("res://Assets/Sound Effects/"+selectedRoom[6])
			GlobalVariables.room_cards_created.append(self)
			#trap_enter.stream=load("res://Assets/Sound Effects/trap_gas_leak.wav")



func _on_perseajastin_timeout() -> void:
	room_dmg_2.visible=false
	
	

func _on_activate_button_pressed() -> void:
	#tässä määritetään damagea varten tarvittavat arvot.
	var hero = entered_hero.get_parent().get_parent()
	var hp = hero.hp
	var selectedHero = hero.selectedHero
	trap_sound.play()
	if !trap_activated:
		match card_name.text:
			"Gas Leak":
				print("Gas Leak: Deals 2 damage to all heroes every time a hero exits this trap.")
				# Add specific game logic here
			"Mimic":
				print("Mimic: If you kill a hero in this room, gain +3 gold.")
				# Add specific game logic here
			"The Vault Room":
				print("The Vault Room: Consume 5 gold to kill a hero in this room (not currently implemented).")
				# Add specific game logic here
			"Hot Coals":
				print("Hot Coals: The heroes take damage from the coals... because they are hot.")
				# Add specific game logic here
			"Pit Fall":
				print("Pit Fall: Kill the hero in this room (not currently implemented).")
				hero.hp = 0
				
				visible = false
			"Spike Trap":
				print("Spike Trap: Deal 6 damage to the hero in this room (not currently implemented).")
				# Add specific game logic here
				damage = 10 + GlobalVariables.TrapDmgBuff
			"Forgotten Library":
				damage = 5 + GlobalVariables.TrapDmgBuff
				if hp<=damage*selectedHero[1]:
					print("lisätään kortti")
					if get_tree().get_first_node_in_group("hand").get_child_count()<6:
						GlobalVariables.resetValues(true)
						GlobalVariables.created_spells-=1
						get_tree().get_first_node_in_group("hand").add_child(card.instantiate())
						get_tree().get_first_node_in_group("hand").startcardmachine()
					#print("Forgotten Library: Once in a turn when a hero dies in this room, get a spell card.")
				# Add specific game logic here
			_:
				print("Unknown trap room:", card_name)
					
		hero.hp-=damage*selectedHero[1]
		activate_button.visible = false
		trap_activated = true
		
		#if GlobalVariables.is_everyone_stopped():
			#GlobalVariables.heroes_move=true

			
