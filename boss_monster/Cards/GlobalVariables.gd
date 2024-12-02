extends Node

var hero_progress = 0
var trap_index=0
var amount_of_heroes_alive = 0
var damageGiven = 0
var heroHp = 10 
var bossHp = 50
var hero_limit = 3
var current_heroes = 0
var timerAmount = 0.0
var spell_limit = 1
var created_spells = 0
var infamy = 1
var amount_of_heroes_killed = 0
var rerollCost = 1
#Arrays
@onready var Database = preload("res://Database/Database.gd")
@onready var rooms: Array[Array] = []
@onready var heroes: Array[Array] = []
@onready var spells: Array[Array] = []
var room_cards_created: Array[Control] = []
var spawned_heroes: Array[PathFollow2D] = []
var rooms_placed: Array[Control] = []
var cardData = []

#Global BOOLEAN checks
var createCard = false
var cardBought = false
var card_dragging = false
var shop_card_dragging = false
var spawn_room_set = false
var timerStart = false
var heroKilled = false
var trap_placed = false 
var spell_dragging=false
var playshopanim = true
var heroes_move = false
var combat_phase = false
var autoplay = false
var spawn_hero = false
var show_card = false


#Card damage buffs
var TrapDmgBuff = 0
var UndeadDmgBuff = 0
var DemonDmgBuff = 0
var HumanoidDmgBuff = 0
var BeastDmgBuff = 0
var ConstructDmgBuff = 0
var SpikeTrapDmgBuff = 0

@onready var actionsLeft = 2
@onready var currentPhase: String = "build"  #Phases are town phase "town", combat phase "combat" and build phase "build"
var card_info = ""
var player_gold = 5

func _ready() -> void:
	resetValues(false)
	
func is_everyone_stopped() -> bool:
	for path in GlobalVariables.spawned_heroes:
		if is_instance_valid(path):
			if path.get_child(0).can_move && !path.get_child(0).mindcontrolled:
				#print("Everyone is not stopped")
				return false
	#print("Everyone is stopped")
	return true

func resetValues(refresh) -> void:
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
	if !refresh:
		spell_limit = 1
		created_spells = 0
		actionsLeft = 2
