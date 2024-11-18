extends Node

var card_dragging = false
var hero_progress = 0
var trap_index=0
var heroes_move = false
var combat_phase = false
var autoplay = false
var spawn_hero = false
var hero_limit = 3
var current_heroes = 0
var timerAmount = 0.0
var spell_limit = 1
var created_spells = 0
@onready var Database = preload("res://Database/Database.gd")
@onready var rooms: Array[Array] = []
@onready var heroes: Array[Array] = []
@onready var spells: Array[Array] = []
var room_cards_created: Array[Control] = []
var damageGiven = 0
var heroHp = 10 
var heroKilled = false
var bossHp = 50
var spawned_heroes: Array[PathFollow2D] = []
var rooms_placed: Array[Control] = []
var spawn_room_set = false
var timerStart = false
var amount_of_heroes_killed = 0
var trap_placed = false 
var spell_dragging=false
@onready var actionsLeft = 2
#Phases are town phase "town", combat phase, "combat" and build phase "build"
@onready var currentPhase: String = "build"

func _ready() -> void:
	resetValues()
	
func is_everyone_stopped() -> bool:
	for path in GlobalVariables.spawned_heroes:
		if is_instance_valid(path):
			if path.get_child(0).can_move && !path.get_child(0).mindcontrolled:
				#print("Everyone is not stopped")
				return false
	#print("Everyone is stopped")
	return true

func resetValues() -> void:
	for i in range(Database.DATA.size()):
		if Database.DATA.get(i)[0]=="Room":
			rooms.append(Database.DATA.get(i))
		i+=1
		
	for i in range(Database.DATA.size()):
		if Database.DATA.get(i)[0]=="Hero":
			heroes.append(Database.DATA.get(i))
		i+=1
	
	for i in range(Database.DATA.size()):
		if Database.DATA.get(i)[0]=="Spell":
			spells.append(Database.DATA.get(i))
		i+=1
	spell_limit = 1
	created_spells = 0
	actionsLeft = 2
