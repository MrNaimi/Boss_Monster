class_name CardUI
extends Control

signal reparent_requested(which_card_ui: CardUI)
signal reset_card()

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


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	initializeCard()
	GlobalVariables.room_cards_created.append(self)
	
	
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

func _on_hit_box_area_exited(area: Area2D) -> void:
	#if self in GlobalVariables.spawn_room:
	if spawn_room:
		GlobalVariables.spawn_hero=true
	pass
	
func initializeCard() -> void:
	rooms = GlobalVariables.rooms
	spells = GlobalVariables.spells
	print("pylly")
		#if GlobalVariables.spawn_room.size()==0:
	#	GlobalVariables.spawn_room.append(self) 
	#print(rooms)
	var i =  RandomNumberGenerator.new().randi_range(0, rooms.size()-1)
	var selectedRoom=rooms.pop_at(i)
	
	i =  RandomNumberGenerator.new().randi_range(0, spells.size()-1)
	var selectedSpell=spells.pop_at(i)
	card_state_machine.init(self)
	if GlobalVariables.created_spells < GlobalVariables.spell_limit:
		print("Yritetään luoda spelliä")
		trap_texture.texture=load(texturepath+selectedSpell[5])
		card_texture.texture=load(texturepath+selectedSpell[5])
		card_name.text = selectedSpell[3]
		room_type.text = selectedSpell[0][0]
		room_dmg.text = str(selectedSpell[1])
		card_info = (selectedSpell[4])
		damage = int(room_dmg.text)
		
		GlobalVariables.created_spells+=1
		card_border.texture=load("res://Cards/Graphics/spellcard.png")
		drop_point_detecor.set_collision_mask_value(3, false)
		drop_point_detecor.set_collision_mask_value(4, true)
		drop_point_detecor.set_collision_layer_value(3, false)
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
			GlobalVariables.room_cards_created.append(self)
			sound = selectedRoom[6]
			#trap_enter.stream=load("res://Assets/Sound Effects/trap_gas_leak.wav")



func _on_perseajastin_timeout() -> void:
	room_dmg_2.visible=false
	
	

func _on_activate_button_pressed() -> void:
	
	var heroes = []
	for item in GlobalVariables.spawned_heroes:
		if is_instance_valid(item):
			heroes.append(item.get_child(0))
			
	#tässä määritetään damagea varten tarvittavat arvot.
	var hero = entered_hero.get_parent().get_parent()
	var hp = hero.hp
	var selectedHero = hero.selectedHero
	var dmg = damage
	GlobalVariables.soundpath = sound
	GlobalVariables.play_trap_sound=true
	if !trap_activated:
		match card_name.text:
			"Gas Leak":
				for person in heroes:
					person.hp-=5
					person.poison_damage.text = "-5"
					person.animations.play("poison_damage")
			"Mimic":
				hero.hp-=GlobalVariables.player_gold
				room_dmg_2.text = GlobalVariables.player_gold
				paskahuussi.play("damagetext")
			"The Vault Room":
				if GlobalVariables.player_gold>=15:
					hero.hp=0
					GlobalVariables.player_gold-=15
					room_dmg_2.text = str(9999)
					paskahuussi.play("damagetext")
			"Hot Coals":
				print("Hot Coals: The heroes take damage from the coals... because they are hot.")
				hero.damageAdd += 3
			"Pit Fall":
				room_dmg_2.text = str(9999)
				hero.hp = 0
				visible = false
				paskahuussi.play("damagetext")
			"Spike Trap":
				# Add specific game logic here
				dmg = 10 + GlobalVariables.TrapDmgBuff
				
				paskahuussi.play("damagetext")
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
					
		hero.hp-=dmg*selectedHero[1]
		activate_button.visible = false
		trap_activated = true
		
		#if GlobalVariables.is_everyone_stopped():
			#GlobalVariables.heroes_move=true

			
