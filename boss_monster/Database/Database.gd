

#BossInfo =[Type, Health, Name, Special Text]
#SpellInfo =[Type, Damage, +Health, Name, Special Text, png]
#RoomInfo =[Type, Damage, Name, Monster or Trap, Special Text, png, sound, Tribe]
enum {
	# Heroes
	Cleric,
	Paladin,
	Monk,
	Barbarian,
	Mage,
	Ranger,
	Lucky_Fellow,
	
	# Bosses
	Skeleton_King,
	Lich,
	Big_Snake,
	Corrupted_Mage,
	
	# Spells
	Shrink_Ray,
	Mind_Control,
	Healing_Potion,
	Assassination,
	Bad_Directions,
	
	# Rooms
	Goblin_Warrior,
	Gas_Leak,
	Mimic,
	The_Vault_Room,
	Spike_Factory,
	Hot_Coals,
	Monster_Lounge,
	The_Dragon_Lair,
	Pit_Fall,
	Spike_Trap,
	Forgotten_Library,
	Succubus,
	Vampire,
	Stinky_Ghoul,
	Misunderstood_Ghost,
	Zombie_Graveyard,
	Rolling_Golem,
	Killer_Robot,
	Angry_Slime,
	Fire_Elemental,
	Imp,
	Warlock_Summoner,
	Demon_Spawn,
	Lesser_Devil,
	Outlaw,
	Orc_Bodyguard,
	Goblin_Army,
	Pack_of_Wolves,
	Chihu,
	Lions_Den,
	Electric_Anomaly,
	Gator,
	Last_Mammoth,
	Repair_Bot,
	Amalgamation,
	Skeleton_Ceo,
	Ominous_Shadow,
	Summoning_Circle,
	Fallen_Angel,
	Undead_Mage,
	Greedy_Goblin, 
	Goblin_General
	}
#enum {Cleric,Paladin, Monk, Barbarian, Mage, Ranger, Lucky_Fellow, Skeleton_King, Lich, Big_Snake, Shrink_Ray, Corrupted_Mage, Mind_Control, Healing_potion, Assassination, Bad_Directions, Goblin_warrior, Gas_Leak, Mimic, The_Vault_Room, Spike_Factory, Hot_Coals, Monster_Lounge,The_Dragon_Lair, Pit_Fall, Spike_Trap, Forgotten_Library, Succubus, Vampire, Misunderstood_Ghost, Zombie_Graveyard, Stinky_Ghoul, Rolling_Golem, Killer_Robot, Angry_Slime, Fire_Elemental, Imp, Warlock_Summoner, Demon_Spawn, Lesser_Devil, Outlaw,Orc_Bodyguard,Goblin_Army, Pack_of_Wolves, Chihu, Lions_Den, Electric_Anomaly,Gator,Last_Mammoth, Repair_Bot, Amalgamation, Ominous_Shadow, Summoning_Circle, Fallen_Angle, Greedy_Goblin,Goblin_General,Skeleton_Ceo}

const DATA ={
	#HeroInfo =[Type, Factor, Hp lower limit, Hp upper limit , Name, Role, Special Text]
	#Hero
	Cleric :
		["Hero", 1,7, 10 ,"cleric", "Healer", ""],
	Paladin :
		["Hero", 1,12, 16, "paladin", "Damage", ""],
	Monk :
		["Hero", 1,10, 14, "monk", "Healer", ""],
	Barbarian :
		["Hero", 2, 20,30, "barbarian", "Healer",""],
	Mage :
		["Hero", 4,40, 48, "mage", "Damage", ""],
	Ranger :
		["Hero", 3,30, 40, "ranger", "Damage",""],
	Lucky_Fellow :
		["Hero", 1,9, 10, "lucky_fellow", "Damage",""],
		
		
	#Boss
	Skeleton_King :
		["Boss", 20, "Skeleton_King", "Wants to raise an army of smaller and smaller skeletons"],
	Lich :
		["Boss", 20, "Lich", "He who  lurks in the dark, plotting to seize forbidden knowledge lost to time itself."],
	Big_Snake :
		["Boss", 20, "Big_Snake", "Too large to be just a snake, but still too small to be a proper wyrm"],
	Corrupted_Mage: 
		["Boss", 20, "Corrupted_Mage", "Will not rest until he has the strongest magic!"],

	#Spells
	Shrink_Ray :
		["Spell","50%", 0, "Shrink Ray", "Reduce heros maximum HP by 50%","shrink_ray.png"],
	Mind_Control :
		["Spell",100 , 0, "Mind Control", "Targeted Hero becomes mindcontrolled and will attack its friends. Effect breaks on damage.","mind_control.png"],
	Healing_Potion :
		["Spell","+10hp", 10, "Healing Potion", "Restore 10 health to your Boss","healing_potion.png"],
	Assassination :
		["Spell", 100, 0, "Assassination", "Kill a targeted hero","assassination.png"],
	Bad_Directions :
		["Spell", 100, 0, "Bad Directions", "Return a hero back to the start of the dungeon","bad_directions.png"],
		
	#Rooms 
	#RoomInfo =[Type, Damage, Name, Monster or Trap, Special Text, png, sound, Tribe]
	Goblin_Warrior : #tehty oikee art
		["Room", 3, "Goblin Warrior", "Monster", "The Goblin Warrior has a 1 in 4 chance to get extra +2 gold from killed Heroes (does not stack with itself)", "goblin_warrior.png","goblin_warrior.wav","humanoid"],
	Gas_Leak : #tehty oikee art
		["Room", 2, "Gas Leak", "Trap", "Activate this trap to deal 6 damage to every hero in the dungeon", "gas_leak.png","","trap"],
	Mimic :#tehty oikee art
		["Room", 3, "Mimic", "Trap", "Activate this trap to deal damage to a hero equal to your gold", "mimic.png","mimic.wav","trap"],
	The_Vault_Room : #tehty 
		["Room", 3, "The Vault Room","Trap", "Activate this trap to consume 5 gold and kill a hero in this room.", "vault_room.png","vault.wav","trap"],
	Spike_Factory :#tehty
		["Room", 4, "Spike Factory","Monster","Your “Spike Traps” deal +3dmg", "spike_factory.png","", "construct"],
	Hot_Coals: #tehty oikee art
		["Room", 4, "Hot Coals","Trap","Activate this trap to burn the hero, dealing 3 damage for every room they enter", "hot_coals.png","","trap"],
	Monster_Lounge: #tehty
		["Room", 3, "Skeleton Lounge", "Monster", "Destroying this room gives +1 dmg to your undead rooms", "monster_lounge.png","","undead"],
	The_Dragon_Lair: #tehty
		["Room", 5, "Dragon Lair", "Monster", "if you kill a hero in this room, get 2 gold", "dragon_lair.png","","beast"],
	Pit_Fall: #tehty oikee art
		["Room", 3, "Pit Fall", "Trap", "Activate this trap to drop the hero into a very deep hole, killing it (not currently implemented)" , "pit_fall.png","hero_death_pit.wav","trap"],
	Spike_Trap : #tehty oikee art
		["Room", 5, "Spike Trap", "Trap", "Activate this trap to deal 10 damage to the hero in this room (not currently implemented)","spikes.png","trap_spikes.wav","trap"],
	Forgotten_Library:
		["Room",3, "Forgotten Library", "Trap","Activate this trap to deal 5 damage to a hero, if the hero dies, get a spell card", "forgotten_library.png","","trap"],
	Succubus : #tehty oikee art0
		["Room", 3, "Succubus", "Monster", "Has 1 in 5 chance to charm the hero, sending him back to the start of the dungeon","succubus.png","","demon"],
	Vampire : #tehty oikee art
		["Room", 5, "Vampire", "Monster", "Deals double damage to clerics","vampire.png","","humanoid, Undead"],
	Stinky_Ghoul : #tehty oikee art
		["Room", 8, "Stinky Ghoul", "Monster", "Your non-Undead monster rooms have -2dmg","stinky_ghoul.png","","undead"],
	Misunderstood_Ghost : #tehty oikee art
		["Room", 4, "Misunderstood Ghost", "Monster", "Deals double damage to Paladins. Destroying this card gives you a spell card (if you have room)","misunderstood_ghost.png","","undead"],
	Zombie_Graveyard : #tehty oikee art
		["Room", 2, "Zombie Graveyard", "Monster", "Has +1dmg for each destroyed room","zombie_graveyard.png","","undead"],
	Rolling_Golem:
		["Room", 4, "Rolling Golem", "Monster", "Benefits more from Tribe buffs, also, It has some rust on it","rolling_golem.png","","construct"],
	Killer_Robot:
		["Room", 6, "Killer Robot", "Monster", "Has a 20% chance to self destruct at the end of every turn","killer_robot.png","","construct"],
	Angry_Slime:
		["Room", 2, "Angry Slime", "Monster", "hero takes 1 more damage for every room they enter","angry_slime.png","","beast"],
	Fire_Elemental:
		["Room", 2, "Fire Elemental", "Monster", "Hero takes 1 damage for every room they entered","fire_elemental.png","","construct"],
	Imp:
		["Room", 2, "Demonic Scout", "Monster", "The hero takes +3dmg from following demon rooms","imp.png","","demon"],
	Warlock_Summoner:
		["Room", 3, "Warlock Summoner", "Monster", "Your demon rooms deal +2 dmg","warlock_summoner.png","","demon, Humanoid"],
	Demon_Spawn:
		["Room", 3, "Demon Spawn", "Monster", "has +3dmg if you have a “Lesser devil” in your dungeon","demon_spawn.png","","demon"],
	Lesser_Devil:
		["Room", 4, "Lesser Devil", "Monster", "Gains +0.5 dmg for each “Demon” type room placed","lesser_devil.png","","demon"],
	Outlaw:
		["Room", 7, "Outlaw", "Monster", "Takes 2 gold every turn as a wage, if you have less than 2 gold, he leaves","outlaw.png","","humanoid"],
	Orc_Bodyguard:
		["Room", 4, "Orc Bodyguard", "Monster", "Gives +2dmg to Humanoids but takes 3 gold per turn as a wage. If you can't afford him, he leaves","orc_bodyguard.png","","humanoid"],
	Goblin_Army:
		["Room", 4, "Goblin Army", "Monster", "The Goblin Army has a 1 in 3 chance to get extra +2 gold from killed heroes in the dungeon (does not stack with itself) ","goblin_army.png","","humanoid"],
	Pack_of_Wolves:
		["Room", 5, "Pack of Wolves", "Monster", "Must kill a hero within 5 rounds or this gets destroyed","pack_of_wolves.png","","beast"],
	Chihu:
		["Room", 2, "Chihu", "Monster", "Pablo the Chihuahua does 1 to 6 extra dmg","chihu.png","","beast"],
	Lions_Den:
		["Room", 3, "Lions Den", "Monster", "Gives your beast rooms +1dmg for each beast in your dungeon","lions_den.png","","beast"],
	Electric_Anomaly:
		["Room", 3, "Electric Anomaly", "Monster", "gives +2 dmg to your “Construct” and “Trap” Rooms","electric_anomaly.png","","construct"],
	Gator:
		["Room",6, "Gator","Monster","If this kills a hero, enrage your other beasts for 3 rounds making them deal +4 dmg","Gator.png","","beast"],
	Last_Mammoth:
		["Room", 6, "The Last Mammoth", "Monster", "Has double base damage if there is no room before it","last_mammoth.png", "", "beast"],
	Repair_Bot:
		["Room", 2, "Repair Bot", "Monster", "Reduces the chance of self destruction by 10%", "repair_bot.png", "", "construct"],
	Amalgamation:
		["Room", 5, "Amalgamation", "Monster", "This has all Tribes", "amalgamation.png", "", "construct"],
	Skeleton_Ceo:
		["Room", 1, "Skeleton CEO", "Monster", "When this kills a hero, add a Skeleton Lounge to your hand", "skeleton_ceo.png", "", "undead"],
	Ominous_Shadow:
		["Room", 5, "Ominous Shadow", "Monster", "if you control a stinky ghoul and misunderstood ghost, give +3 to your undead rooms", "ominous_shadow.png", "", "undead"],
	Summoning_Circle:
		["Room", 3, "Summoning Circle", "Monster", "has +2 for each Succubus you control and gives +2dmg to each of your Demonic Scouts", "pentagram.png", "", "demon"],
	Fallen_Angel:
		["Room", 5, "Fallen Angel", "Monster", "Gains 3 dmg for each successful succubus charm","fallen_angel.png", "", "demon"],
	Undead_Mage:
		["Room", 3, "Undead Mage", "Monster", "Gain +2dmg for each casted spell","Undead_mage.png", "", "undead"],
	Goblin_General:
		["Room", 4, "Goblin General", "Monster", "Your Goblin Warrior and Goblin Army troops generate one more gold","goblin_general.png", "", "humanoid"],
	Greedy_Goblin:
		["Room", 2, "Greedy Goblin", "Monster", "Gain +1dmg for each 10 gold you have","greedy_goblin.png", "", "humanoid"]
} 
