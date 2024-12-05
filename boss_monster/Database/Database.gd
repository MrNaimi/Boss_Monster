
#HeroInfo =[Type, Factor, Hp, , Name, Role, Special Text]
#BossInfo =[Type, Health, Name, Special Text]
#SpellInfo =[Type, Damage, +Health, Name, Special Text, png]
#RoomInfo =[Type, Damage, Name, Monster or Trap, Special Text, png, sound, Tribe]

enum {Cleric,Paladin, Monk, Barbarian, Mage, Ranger, Lucky_Fellow, Skeleton_King, Lich, Big_Snake, Shrink_Ray, Corrupted_Mage, Mind_Control, Healing_potion, Assassination, Bad_Directions, Goblin_warrior, Gas_Leak, Mimic, The_Vault_Room, Spike_Factory, Hot_Coals, Monster_Lounge,The_Dragon_Lair, Pit_Fall, Spike_Trap, Forgotten_Library, Succubus, Vampire, Misunderstood_Ghost, Zombie_Graveyard, Stinky_Ghoul, Rolling_Golem, Killer_Robot, Angry_Slime, Fire_Elemental, Imp, Warlock_Summoner, Demon_Spawn, Lesser_Devil, Outlaw,Orc_Bodyguard,Goblin_Army, Pack_of_Wolves, Chihu, Lions_Den, Electric_Anomaly}

const DATA ={
	
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
		["Spell","50%", 0, "Shrink Ray", "Reduce heros maximum HP by 5","shrink_ray.png"],
	Mind_Control :
		["Spell",100 , 0, "Mind Control", "Targeted Hero deals damage to an adjacent hero","mind_control.png"],
	Healing_potion :
		["Spell","+10hp", 10, "Healing Potion", "Restore 10 health to your Boss","healing_potion.png"],
	Assassination :
		["Spell", 100, 0, "Assassination", "Kill a targeted hero","assassination.png"],
	Bad_Directions :
		["Spell", 100, 0, "Bad Directions", "Return a hero back to the start of the dungeon","bad_directions.png"],
		
	#Rooms 
	#RoomInfo =[Type, Damage, Name, Monster or Trap, Special Text, png, sound, Tribe]
	Goblin_warrior : #tehty oikee art
		["Room", 3, "Goblin Warrior", "Monster", "The Goblin Warrior has a 1 in 4 chance to get extra +2 gold from killed Heroes (does not stack with itself)", "goblin_warrior.png","goblin_warrior.wav","humanoid"],
	Gas_Leak : #tehty oikee art
		["Room", 2, "Gas Leak", "Trap", "Deals 2 damage to all heroes every time a hero exits this trap", "gas_leak.png","","trap"],
	Mimic :#tehty oikee art
		["Room", 3, "Mimic", "Trap", "If you kill a hero in this room, gain +3 gold", "mimic.png","mimic.wav","trap"],
	The_Vault_Room : #tehty 
		["Room", 3, "The Vault Room","Trap", "Consume 5 gold to kill a hero in this room (not currently implemented)", "vault_room.png","vault.wav","trap"],
	Spike_Factory :#tehty
		["Room", 4, "Spike Factory","Monster","Your “Spike Traps” deal +3dmg (not currently implemented)", "spike_factory.png","", "construct"],
	Hot_Coals: #tehty oikee art
		["Room", 4, "Hot Coals","Trap","The heroes take damage from the coals...\n...because they are hot", "hot_coals.png","","trap"],
	Monster_Lounge: #tehty
		["Room", 3, "Skeleton Lounge", "Monster", "Destroying this room gives +2 undead damage", "monster_lounge.png","","undead"],
	The_Dragon_Lair: #tehty
		["Room", 5, "Dragon Lair", "Monster", "if you kill a hero in this room, get 2 gold", "dragon_lair.png","","beast"],
	Pit_Fall: #tehty oikee art
		["Room", 3, "Pit Fall", "Trap", "Kill the hero in this room (not currently implemented)" , "pit_fall.png","hero_death_pit.wav","trap"],
	Spike_Trap : #tehty oikee art
		["Room", 3, "Spike Trap", "Trap", "Deal 6 damage to the hero in this room (not currently implemented)","spikes.png","trap_spikes.wav","trap"],
	Forgotten_Library:
		["Room",3, "Forgotten Library", "Trap","Once in a turn when a hero dies in this room, get a spell card", "forgotten_library.png","","trap"],
	Succubus : #tehty oikee art
		["Room", 3, "Succubus", "Monster", "Has 1 in 3 chance to deal double damage","succubus.png","","demon"],
	Vampire : #tehty oikee art
		["Room", 5, "Vampire", "Monster", "Deals double damage to clerics","vampire.png","","humanoid"],
	Stinky_Ghoul : #tehty oikee art
		["Room", 8, "Stinky Ghoul", "Monster", "Your non-Undead monster rooms have -2dmg","stinky_ghoul.png","","undead"],
	Misunderstood_Ghost : #tehty oikee art
		["Room", 4, "Misunderstood Ghost", "Monster", "Deals double damage to Paladins","misunderstood_ghost.png","","undead"],
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
		["Room", 2, "Demonic Scout", "Monster", "Heroes that pass this room take +2 dmg from “Demon” type Rooms","imp.png","","demon"],
	Warlock_Summoner:
		["Room", 3, "Warlock Summoner", "Monster", "Your 'Demon' type rooms deal +2dmg","warlock_summoner.png","","demon"],
	Demon_Spawn:
		["Room", 3, "Demon Spawn", "Monster", "has +3dmg if you have a “Lesser devil” in your dungeon","demon_spawn.png","","demon"],
	Lesser_Devil:
		["Room", 4, "Lesser Devil", "Monster", "Gains +0.5 dmg for each “Demon” type room placed","lesser_devil.png","","demon"],
	Outlaw:
		["Room", 7, "Outlaw", "Monster", "He takes 2 gold every turn as a wage, if you have less than 2 gold, If you can't afford him, he leaves","outlaw.png","","humanoid"],
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
} 
