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
@export var trap_dmg: int = 1
@onready var card_border: Sprite2D = $CardBorder
@onready var card_name: Label = $CardName
@onready var rooms: Array[Array] = GlobalVariables.rooms

# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	#print(rooms)
	
	var i =  RandomNumberGenerator.new().randi_range(0, rooms.size()-1)
	#print(rooms[i])
	var selectedRoom=rooms.pop_at(i)
	#print("selected room ",selectedRoom)
#
	#print()
	#print("all rooms ",rooms)
	#print("Current size of rooms[]: ",rooms.size())
	#print()
	#'
	
	
	card_state_machine.init(self)
	
	
	trap_dmg=RandomNumberGenerator.new().randf_range(1,3)
	var trap=GlobalVariables.traps[GlobalVariables.trap_index]
	GlobalVariables.trap_index+=1
	var texture = load(texturepath+trap)
	trap_texture.texture=texture
	card_texture.texture=texture



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
	print(self," <--- resetting this card")
	reset_card.emit()
	
