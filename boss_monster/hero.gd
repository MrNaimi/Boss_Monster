extends Node2D
@onready var health_bar: ProgressBar = $healthBar
@onready var idle_animation: AnimatedSprite2D = $Idle_animation
@onready var hp = 1
#@onready var hp = RandomNumberGenerator.new().randi_range(10,15)
var selectedHero = []
@onready var heroes: Array[Array] = GlobalVariables.heroes
@onready var can_move = true
@onready var path_direction = 1
@onready var flipped = false
@onready var mindcontrolled = false
@onready var hero_class: String
@onready var damageMult
@onready var killed_by_boss = false
@onready var card: PackedScene = preload("res://Cards/card_ui.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalVariables.spawned_heroes.append(get_parent())
	GlobalVariables.amount_of_heroes_alive += 1
	#health_bar.max_value = hp
	var i =  RandomNumberGenerator.new().randi_range(0, heroes.size()-1)
	selectedHero=heroes[i]
	hp = round(RandomNumberGenerator.new().randi_range(selectedHero[2],selectedHero[3]))
	print("Hp before infamy scaling: ",hp," ")
	hp *= round((0.5+0.25*GlobalVariables.infamy))
	print("Hp after infamy scaling: ",hp," ")
	health_bar.max_value = hp
	idle_animation.animation = selectedHero[4]
	hero_class=selectedHero[4]
	damageMult = selectedHero[1]
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:		
	health_bar.value = hp
	#print(hp)
	
	if hp <= 0:
		if GlobalVariables.goblin_warrior_active:
			if RandomNumberGenerator.new().randi_range(1, 4)==4:
				GlobalVariables.player_gold+=2
		if GlobalVariables.autoplay:
			GlobalVariables.heroes_move=true
		GlobalVariables.heroKilled = true
		get_parent().queue_free()
		GlobalVariables.amount_of_heroes_alive-=1
		GlobalVariables.amount_of_heroes_killed+=1
		if !killed_by_boss:
			GlobalVariables.player_gold+=RandomNumberGenerator.new().randi_range(2, 4)
	if get_parent().progress < 50:
		path_direction = 1
		flipped = false

func _on_hit_box_area_entered(area: Area2D) -> void:
	#GlobalVariables.heroes_move=false
	if area.get_parent().get_parent().name!="Hero" or area.get_parent().get_parent().mindcontrolled:
			can_move = false
			if GlobalVariables.autoplay:
				GlobalVariables.timerStart = true
			
			
func _on_hit_box_area_exited(area: Area2D) -> void:
	var room_name = ""
	if area.get_parent() is AnimatedSprite2D:
		room_name = "Hero"
	elif area.get_parent().name != "Boss":
		room_name = area.get_parent().card_name.text
	else:
		room_name = "Boss"
		
	var room_damage =  area.get_parent().damage*selectedHero[1] # TÄSSÄ MÄÄRITELLÄÄN HUONEEN DAMAGE
	
	#SEURAAVAKSI MÄÄRITELLÄÄN KAIKKI HEROT
	var heroes = []
	for item in GlobalVariables.spawned_heroes:
		if is_instance_valid(item):
			heroes.append(item.get_child(0))
	
	#damage multiplier = *selectedHero[1]
	
	#print("Exited trap damage: ",area.get_parent().damage)
	#trapissa olevan heron hp = hp
	#KAIKKI HEROT ON "heroes"
	#RAHA ON GlobalVariables.player_gold
	#jos kysyttävää koodauksesta soita 044 339 7453
	match room_name:
		"Goblin Warrior": #TEHTY
			room_damage+=GlobalVariables.HumanoidDmgBuff
			print("Handle Goblin Warrior room")
		"Gas Leak": #TEHTY
			room_damage+=GlobalVariables.TrapDmgBuff
			for hero in heroes:
				hero.hp -= 2*hero.damageMult
			print("Handle Gas Leak room")
		"Mimic": #TEHTY
			room_damage+=GlobalVariables.TrapDmgBuff
			hp -= room_damage*selectedHero[1]
			if hp<=0:
				GlobalVariables.player_gold+=5
			room_damage = 0
			print("Handle Mimic room")
		"The Vault Room": #SKIP
			room_damage+=GlobalVariables.TrapDmgBuff
			
			print("Handle The Vault Room")
		"Spike Factory": #TEHTY
			room_damage+=GlobalVariables.ConstructDmgBuff
			print("Handle Spike Factory room")
		"Hot Coals": #SKIP
			room_damage+=GlobalVariables.TrapDmgBuff
			print("Handle Hot Coals room")
		"Monster Lounge": #TEHTY/SKIP
			room_damage+=round(1.5*GlobalVariables.UndeadDmgBuff)
			print("Handle Monster Lounge room")
		"The Dragon Lair": #TEHTY
			room_damage+=GlobalVariables.BeastDmgBuff
			hp -= room_damage*selectedHero[1]
			if hp<=0:
				GlobalVariables.player_gold+=2
			room_damage = 0
			print("Handle The Dragon Lair room")
		"Pit Fall": #SKIP
			room_damage+=GlobalVariables.TrapDmgBuff
			print("Handle Pit Fall room")
		"Spike Trap": #SKIP
			room_damage+=GlobalVariables.TrapDmgBuff
			print("Handle Spike Trap room")
		"Forgotten Library": #TEHTY
			room_damage+=GlobalVariables.TrapDmgBuff
			hp -= room_damage*selectedHero[1]
			if hp<=0 && !GlobalVariables.forgotten_library_activated:
				GlobalVariables.forgotten_library_activated = true
				print("lisätään kortti")
				if get_tree().get_first_node_in_group("hand").get_child_count()<6:
					GlobalVariables.resetValues(true)
					GlobalVariables.created_spells-=1
					get_tree().get_first_node_in_group("hand").add_child(card.instantiate())
			room_damage = 0
			print("Handle Forgotten Library room")
		"Succubus": 
			room_damage+=GlobalVariables.DemonDmgBuff
			if RandomNumberGenerator.new().randi_range(1, 3)==3:
				room_damage*2
				print("succubus room delt double damage")
			print("Handle Succubus room")
		"Vampire":
			room_damage+=GlobalVariables.HumanoidDmgBuff
			if hero_class=="cleric":
				room_damage*=2
			print("Handle Vampire room")
		"Stinky Ghoul":
			room_damage+=GlobalVariables.UndeadDmgBuff
			
			print("Handle Stinky Ghoul room")
		"Misunderstood Ghost":
			room_damage+=GlobalVariables.UndeadDmgBuff
			if hero_class=="paladin":
				room_damage*=2
			print("Handle Misunderstood Ghost room")
		"Zombie Graveyard":
			room_damage+=GlobalVariables.UndeadDmgBuff
			room_damage+=GlobalVariables.rooms_destroyed
			print("Handle Zombie Graveyard room")
		"Rolling Golem":
			room_damage+=(1.5*GlobalVariables.ConstructDmgBuff)
			print("Handle Rolling Golem room")
		"Killer Robot":#SKIP
			room_damage+=GlobalVariables.ConstructDmgBuff
			print("Handle Killer Robot room")
		"Angry Slime":
			room_damage+=GlobalVariables.BeastDmgBuff
			selectedHero[1]*=1.1
			print("Handle Angry Slime room")
		"Fire Elemental":#SKIP
			room_damage+=GlobalVariables.ConstructDmgBuff
			print("Handle Fire Elemental room")
		"Demonic Scout":#SKIP
			room_damage+=GlobalVariables.DemonDmgBuff
			print("Handle Demonic Scout room")
		"Warlock Summoner":#TEHTY
			room_damage+=GlobalVariables.DemonDmgBuff
			print("Handle Warlock Summoner room")
		"Demon Spawn": #TEHTY
			room_damage+=GlobalVariables.DemonDmgBuff
			if GlobalVariables.lesser_devil_in_dungeon:
				room_damage+=3
			print("Handle Demon Spawn room")
		"Lesser Devil": #TEHTY
			room_damage+=GlobalVariables.DemonDmgBuff
			room_damage+=GlobalVariables.demon_rooms_placed
			print("Handle Lesser Devil room")
			
		"Outlaw":
			room_damage+=GlobalVariables.HumanoidDmgBuff
			print("Handle Outlaw room")
		"Orc Bodyguard":
			room_damage+=GlobalVariables.HumanoidDmgBuff
			print("Handle Orc Bodyguard room")
		"Goblin Army":
			room_damage+=GlobalVariables.HumanoidDmgBuff
			print("Handle Goblin Army room")
		"Pack of Wolves":
			room_damage+=GlobalVariables.BeastDmgBuff
			print("Handle Pack of Wolves room")
		"Chihu":
			room_damage+=GlobalVariables.BeastDmgBuff
			print("Handle Chihu room")
		"Lions Den":
			room_damage+=GlobalVariables.BeastDmgBuff
			print("Handle Lions Den room")
		"Electric Anomaly":
			room_damage+=GlobalVariables.ConstructDmgBuff
			print("Handle Electric Anomaly room")
		"Boss":
			print("boss boss bossss")
		_:
			print("Unknown room:", room_name)
			
	print("Damage dealt by room: ",room_damage)
	
	hp -= room_damage *selectedHero[1]

	if mindcontrolled:
		hp-=floor(0.5*hp)
		mindcontrolled = false
		flipped = false
	get_child(0).damage = 0
	#print(hp)
	
	

func isEveryoneStopped () -> bool:
	for path in GlobalVariables.spawned_heroes:
		if is_instance_valid(path):
			if path.get_child(0).can_move:
				return false
	return true
