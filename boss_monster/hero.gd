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
@onready var perseajastin: Timer = $perseajastin
@onready var animations: AnimationPlayer = $animations
@onready var poison_damage: Label = $PoisonDamage

var visited_demon_scouts = 0
var damageAdd = 0
var rooms_entered = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalVariables.spawned_heroes.append(get_parent())
	GlobalVariables.amount_of_heroes_alive += 1
	#health_bar.max_value = hp
	var i =  RandomNumberGenerator.new().randi_range(0, heroes.size()-1)
	selectedHero=heroes[i]
	hp =  RandomNumberGenerator.new().randi_range(selectedHero[2],selectedHero[3])
	print("Hp before infamy scaling: ",hp," ")
	hp = round(hp*(0.5+0.25*GlobalVariables.infamy))
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
		
		if GlobalVariables.goblin_warriors_in_dungeon >= 1:
			if RandomNumberGenerator.new().randi_range(1,4)==4:
				GlobalVariables.player_gold+=2
				GlobalVariables.goblin_warrior_animation = true
		if GlobalVariables.goblin_armies_in_dungeon >= 1:
			if RandomNumberGenerator.new().randi_range(1,3)==3:
				GlobalVariables.player_gold+=2
				GlobalVariables.goblin_army_animation = true
		if GlobalVariables.autoplay:
			GlobalVariables.heroes_move=true
		GlobalVariables.heroKilled = true
		GlobalVariables.heroes_killed += 1
		GlobalVariables.amount_of_heroes_alive-=1
		GlobalVariables.amount_of_heroes_killed+=1
		if !killed_by_boss:
			GlobalVariables.player_gold+=RandomNumberGenerator.new().randi_range(1, 4)
		print(GlobalVariables.rooms_placed)
		if GlobalVariables.rooms_placed.is_empty():
			GlobalVariables.spawn_hero= true
			GlobalVariables.spawn_room_set = true
				
		#for room in GlobalVariables.rooms_placed:
			#print("perseeee")
			#
			#if is_instance_valid(room):
				#break
			#else:
				#print("spawn hero")
				#
				#
		get_parent().queue_free()
	if get_parent() is PathFollow2D:
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
	rooms_entered+=1
	if area.get_parent() is AnimatedSprite2D:
		room_name = "Hero"
	elif area.get_parent().name != "Boss":
		room_name = area.get_parent().card_name.text
	else:
		room_name = "Boss"
		
	var room_damage =  area.get_parent().damage # TÄSSÄ MÄÄRITELLÄÄN HUONEEN DAMAGE
	
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
			#for hero in heroes:
				#hero.hp -= floor(2+GlobalVariables.TrapDmgBuff*0.34)*hero.damageMult
				#hero.poison_damage.text = "-2"
				#GlobalVariables.damage_done+=2
				#hero.animations.play("poison_damage")
			#print("Handle Gas Leak room")
		"Mimic": #TEHTY
			room_damage+=GlobalVariables.TrapDmgBuff
			if hp<=room_damage*selectedHero[1]:
				GlobalVariables.player_gold+=3
				area.get_parent().paskahuussi.play("money_animation")
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
			if hp<=room_damage*selectedHero[1]:
				GlobalVariables.player_gold+=2
			print("Handle The Dragon Lair room")
		"Pit Fall": #SKIP
			room_damage+=GlobalVariables.TrapDmgBuff
			print("Handle Pit Fall room")
		"Spike Trap": #SKIP
			room_damage+=GlobalVariables.TrapDmgBuff
			room_damage+=GlobalVariables.SpikeTrapDmgBuff
			print("Handle Spike Trap room")
		"Forgotten Library": #TEHTY
			room_damage+=GlobalVariables.TrapDmgBuff
			print("Handle Forgotten Library room")
		"Succubus": #TEHTY
			if visited_demon_scouts>0:
				room_damage+=3*visited_demon_scouts
			room_damage+=GlobalVariables.DemonDmgBuff
			if RandomNumberGenerator.new().randi_range(1,5)==5:
				path_direction *= -1
				flipped = not flipped
				GlobalVariables.succubus_charms+=1
			print("Handle Succubus room")
		"Vampire":#TEHTY
			room_damage+=GlobalVariables.HumanoidDmgBuff
			room_damage+=GlobalVariables.UndeadDmgBuff
			if hero_class=="cleric":
				room_damage*=2
			print("Handle Vampire room")
		"Stinky Ghoul":#TEHTY
			room_damage+=GlobalVariables.UndeadDmgBuff
			print("Handle Stinky Ghoul room")
		"Misunderstood Ghost":#TEHTY
			room_damage+=GlobalVariables.UndeadDmgBuff
			if hero_class=="paladin":
				room_damage*=2
			print("Handle Misunderstood Ghost room")
		"Zombie Graveyard": #TEHTY
			room_damage+=GlobalVariables.UndeadDmgBuff
			room_damage+=GlobalVariables.rooms_destroyed
			print("Handle Zombie Graveyard room")
		"Rolling Golem": #TEHTY
			room_damage+=(1.5*GlobalVariables.ConstructDmgBuff)
			print("Handle Rolling Golem room")
		"Killer Robot":#TEHTY
			room_damage+=GlobalVariables.ConstructDmgBuff
			print("Handle Killer Robot room")
		"Angry Slime":#TEHTY
			room_damage+=GlobalVariables.BeastDmgBuff
			damageAdd +=1
			print("Handle Angry Slime room")
		"Fire Elemental":#TEHTY
			room_damage+=rooms_entered
			room_damage+=GlobalVariables.ConstructDmgBuff
			print("Handle Fire Elemental room")
		"Demonic Scout":#TEHTY, IMP
			room_damage+=3*visited_demon_scouts
			visited_demon_scouts +=1
			room_damage+=GlobalVariables.summoning_circles*2
			room_damage+=GlobalVariables.DemonDmgBuff
			print("Handle Demonic Scout room")
		"Warlock Summoner":#TEHTY
			room_damage+=3*visited_demon_scouts
			room_damage+=GlobalVariables.DemonDmgBuff
			room_damage+=GlobalVariables.UndeadDmgBuff
			print("Handle Warlock Summoner room")
		"Demon Spawn": #TEHTY
			if visited_demon_scouts>0:
				room_damage+=3*visited_demon_scouts
			room_damage+=GlobalVariables.DemonDmgBuff
			if GlobalVariables.lesser_devils_in_dungeon>0:
				room_damage+=3
			
			print("Handle Demon Spawn room")
		"Lesser Devil": #TEHTY
			if visited_demon_scouts>0:
				room_damage+=3*visited_demon_scouts
			room_damage+=GlobalVariables.DemonDmgBuff
			room_damage+=floor(GlobalVariables.demon_rooms_placed)
			print("Handle Lesser Devil room")
		"Outlaw": #TEHTY
			room_damage+=GlobalVariables.HumanoidDmgBuff	
			print("Handle Outlaw room")
		"Orc Bodyguard": #TEHTY
			room_damage+=GlobalVariables.HumanoidDmgBuff
			print("Handle Orc Bodyguard room")
		"Goblin Army": #TEHTY
			room_damage+=GlobalVariables.HumanoidDmgBuff
			print("Handle Goblin Army room")
		"Pack of Wolves": #SKIP
			room_damage+=GlobalVariables.BeastDmgBuff
			print("Handle Pack of Wolves room")
		"Chihu": #TEHTY
			room_damage+=GlobalVariables.BeastDmgBuff
			room_damage+=RandomNumberGenerator.new().randi_range(1, 6)
			print("Handle Chihu room")
		"Lions Den": #TEHTY
			room_damage+=GlobalVariables.BeastDmgBuff
			print("Handle Lions Den room")
		"Electric Anomaly": #TEHTY
			room_damage+=GlobalVariables.ConstructDmgBuff
			print("Handle Electric Anomaly room")
		"Gator":#skip
			if hp<=room_damage*selectedHero[1]:
				GlobalVariables.gatorDmgBuff=3
			
		"Last Mammoth":#skip
			room_damage+=GlobalVariables.BeastDmgBuff
		"Repair Bot":#tehty
			room_damage+=GlobalVariables.ConstructDmgBuff
			print("Handle repair bot")
		"Amalgamation":#tehty
			room_damage+=GlobalVariables.ConstructDmgBuff
			room_damage+=GlobalVariables.BeastDmgBuff
			room_damage+=GlobalVariables.HumanoidDmgBuff
			room_damage+=GlobalVariables.DemonDmgBuff
			room_damage+=GlobalVariables.UndeadDmgBuff
		"Skeleton CEO": #tehty
			room_damage+=GlobalVariables.UndeadDmgBuff
			if !GlobalVariables.skeleton_ceo_activated:
				if hp<=room_damage*selectedHero[1]:
					if get_tree().get_first_node_in_group("hand").get_child_count()<6:
							GlobalVariables.giveCard("Skeleton Lounge")
							get_tree().get_first_node_in_group("hand").add_child(card.instantiate())
							get_tree().get_first_node_in_group("hand").startcardmachine()
					GlobalVariables.resetValues(true)
					GlobalVariables.skeleton_ceo_activated = true
		"Ominous Shadow":
			room_damage+=GlobalVariables.UndeadDmgBuff
			if GlobalVariables.stinky_ghouls>0 && GlobalVariables.misunderstood_ghosts>0:
				GlobalVariables.UndeadDmgBuff+=5
		"Summoning Circle":
			room_damage+=GlobalVariables.DemonDmgBuff
			room_damage+=GlobalVariables.succubi_placed*2
		"Fallen Angel":
			room_damage+=GlobalVariables.DemonDmgBuff
			room_damage+=GlobalVariables.succubus_charms*3
		"Boss":
			print("boss boss bossss")
			hp = 0
		_:
			print("Unknown room:", room_name)
			
	print("Damage dealt by room: ",room_damage)
	
	if GlobalVariables.gatorDmgBuff>0:
		room_damage+=4
	if area.get_parent().name != "Boss" && area.get_parent().get_parent().name != "Hero":
		area.get_parent().room_dmg_2.text = str(damageAdd+room_damage)
		#area.get_parent().room_dmg_2.visible = true
		#area.get_parent().perseajastin.start()
		area.get_parent().paskahuussi.play("damagetext")
	GlobalVariables.damage_done += (damageAdd+room_damage)
	hp -= (damageAdd+room_damage)*selectedHero[1]
	
	if mindcontrolled:
		GlobalVariables.damage_done+=floor(0.5*hp)
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
