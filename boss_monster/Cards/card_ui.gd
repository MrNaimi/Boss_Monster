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
@onready var room_type: Label = $Control/RoomType
@onready var room_dmg: Label = $Control/RoomDmg
@onready var card_name: Label = $Control/CardName
@onready var damage = int(room_dmg.text)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	#print(rooms)
	
	var i =  RandomNumberGenerator.new().randi_range(0, rooms.size()-1)
	
	var selectedRoom=rooms.pop_at(i)
	
	card_state_machine.init(self)

	trap_texture.texture=load(texturepath+selectedRoom[5])
	card_texture.texture=load(texturepath+selectedRoom[5])
	card_name.text = selectedRoom[2]
	room_type.text = selectedRoom[3][0]
	room_dmg.text = str(selectedRoom[1])
	damage = int(room_dmg.text)


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
	#print("trap entered")
	pass


func _on_hit_box_area_exited(area: Area2D) -> void:
	GlobalVariables.spawn_hero=true
	pass
