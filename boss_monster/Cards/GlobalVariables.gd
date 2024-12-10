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
var rooms_destroyed = 0
var demon_rooms_placed = 0
var beast_rooms_in_dungeon = 0

#Arrays
@onready var Database = preload("res://Database/Database.gd")
@onready var rooms: Array[Array] = []
@onready var heroes: Array[Array] = []
@onready var spells: Array[Array] = []
var room_cards_created: Array[Control] = []
var spawned_heroes: Array[PathFollow2D] = []
var rooms_placed: Array[Control] = []
var cardData = []
var card_info = ["a","b","c"]
var room_to_be_destroyed

var outlaws=[]
var orc_bodyguards=[]

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
var message_sent = false
var message_data = ""
var destroy_room = false
var values_changed = false

var goblin_warrior_active = false
var forgotten_library_activated = false
var lesser_devils_in_dungeon = 0
var outlaws_in_dungeon = 0
var orc_bodyguards_in_dungeon = 0
var goblin_army_active = false
var lions_dens_in_the_dungeon = 0
var killer_robot_terminate = false
var killer_robot_placed = false
var pack_of_wolves_placed = 0
var goblin_army_animation = false
var goblin_warrior_animation = false
var round_counter = 0
var outlaw_animation = false
var orc_bodyguard_animation = false
var goblin_warriors_in_dungeon = 0
var goblin_armies_in_dungeon = 0
#Card damage buffs
var TrapDmgBuff = 0
var UndeadDmgBuff = 0
var DemonDmgBuff = 0
var HumanoidDmgBuff = 0
var BeastDmgBuff = 0
var ConstructDmgBuff = 0
var SpikeTrapDmgBuff = 0

@onready var actionsLeft = 5
@onready var currentPhase: String = "build"  #Phases are town phase "town", combat phase "combat" and build phase "build"
#var card_info = ""
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

func message(msg,card_placed) -> void:
	show_card = true
	message_sent = true
	if card_placed:
		card_info[0] = msg
		message_sent = false
	else:
		card_info[0] = msg
		message_sent = true
		destroy_room = false

func placed_message(msg,tribe,card_placed,node,room_dmg) -> void:
	card_info[1] = tribe
	card_info[2]= room_dmg
	message(msg, true)
	room_to_be_destroyed=node
	if currentPhase=="build":
		destroy_room = true
	else:
		destroy_room = false
func printDmgBuffs() -> void:
	print("Damage Buffs:")
	print("Trap Damage: ", TrapDmgBuff)
	print("Undead Damage: ", UndeadDmgBuff)
	print("Demon Damage: ", DemonDmgBuff)
	print("Humanoid Damage: ", HumanoidDmgBuff)
	print("Beast Damage: ", BeastDmgBuff)
	print("Construct Damage: ", ConstructDmgBuff)
	print("Spike Trap Damage: ", SpikeTrapDmgBuff)


func reset_defaults() -> void:
	# Reset primitive variables
	hero_progress = 0
	trap_index = 0
	amount_of_heroes_alive = 0
	damageGiven = 0
	heroHp = 10
	bossHp = 50
	hero_limit = 3
	current_heroes = 0
	timerAmount = 0.0
	spell_limit = 1
	created_spells = 0
	infamy = 1
	amount_of_heroes_killed = 0
	rerollCost = 1

	# Reset arrays
	rooms = []
	heroes = []
	spells = []
	room_cards_created = []
	spawned_heroes = []
	rooms_placed = []
	cardData = []
	card_info = ["a", "b", "c"]
	room_to_be_destroyed = null

	# Reset booleans
	createCard = false
	cardBought = false
	card_dragging = false
	shop_card_dragging = false
	spawn_room_set = false
	timerStart = false
	heroKilled = false
	trap_placed = false
	spell_dragging = false
	playshopanim = true
	heroes_move = false
	combat_phase = false
	autoplay = false
	spawn_hero = false
	show_card = false
	message_sent = false
	message_data = ""
	destroy_room = false

	# Reset card damage buffs
	TrapDmgBuff = 0
	UndeadDmgBuff = 0
	DemonDmgBuff = 0
	HumanoidDmgBuff = 0
	BeastDmgBuff = 0
	ConstructDmgBuff = 0
	SpikeTrapDmgBuff = 0
	rooms_destroyed = 0
