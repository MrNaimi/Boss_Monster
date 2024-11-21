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
		trap_texture.texture=load(texturepath+selectedRoom[5])
		card_texture.texture=load(texturepath+selectedRoom[5])
		card_name.text = selectedRoom[2]
		room_type.text = selectedRoom[3][0]
		room_dmg.text = str(selectedRoom[1]*floor(1+0.1*GlobalVariables.infamy))
		damage = int(room_dmg.text)
		card_info = (selectedRoom[4])
		GlobalVariables.rooms_placed.append(self)
		#trap_enter.stream=load("res://Assets/Sound Effects/trap_gas_leak.wav")
	if get_parent().get_parent().name == "ShopUI":
		shop_card=true
