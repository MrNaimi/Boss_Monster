
#HeroInfo =[Type, Factor, Hp, , Name, Role, Special Text]
#BossInfo =[Type, Health, Name, Special Text]
#SpellInfo =[Type, Damage, +Health, Name, Special Text, png]
#RoomInfo =[Type, Damage, Name, Monster or Trap, Special Text, png, sound, Tribe]

enum {Cleric,Paladin, Monk, Barbarian, Mage, Ranger, Lucky_Fellow, Skeleton_King, Lich, Big_Snake, Shrink_Ray, Corrupted_Mage, Mind_Control, Healing_potion, Assassination, Bad_Directions, Goblin_warrior, Gas_Leak, Mimic, The_Vault_Room, Spike_Factory, Hot_Coals, Monster_Lounge,The_Dragon_Lair, Pit_Fall, Spike_Trap, Forgotten_Library, Succubus, Vampire, Misunderstood_Ghost, Zombie_Graveyard, Stinky_Ghoul, Rolling_Golem, Killer_Robot, Angry_Slime, Fire_Elemental, Imp, Warlock_Summoner, Demon_Spawn, Lesser_Devil, Outlaw,Orc_Bodyguard,Goblin_Army, Pack_of_Wolves, Chihu, Lions_Den, Electric_Anomaly}

const DATA ={
	
	#Hero
	Cleric :
		["Hero", 1,7, 9 ,"cleric", "Healer", ""],
	Paladin :
		["Hero", 1,14, 17, "paladin", "Damage", ""],
	Monk :
		["Hero", 1,10, 13, "monk", "Healer", ""],
	Barbarian :
		["Hero", 3, 30,39, "barbarian", "Healer",""],
	Mage :
		["Hero", 5,50, 55, "mage", "Damage", ""],
	Ranger :
		["Hero", 4,40, 48, "ranger", "Damage",""],
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
	Goblin_warrior : #tehty oikee art
		["Room", 2, "Goblin Warrior", "Monster", "has a 25% chance to get extra +1 gold from killed Heroes", "goblin_warrior.png","goblin_warrior.wav","humanoid"],
	Gas_Leak : #tehty oikee art
		["Room", 2, "Gas Leak", "Trap", "Deals 1 damage to all heroes", "gas_Leak.png"],
	Mimic :#tehty oikee art
		["Room", 3, "Mimic", "Trap", "", "mimic.png","mimic.wav"],
	The_Vault_Room : #tehty 
		["Room", 3, "The Vault Room","Trap", "", "vault_room.png","vault.wav"],
	Spike_Factory :#tehty
		["Room", 4, "Spike Factory","Monster","Your “Spike Traps” deal +3dmg", "spike_factory.png","", "construct"],
	Hot_Coals: #tehty oikee art
		["Room", 3, "Hot Coals","Trap","", "hot_coals.png"],
	Monster_Lounge: #tehty
		["Room", 4, "Skeleton Lounge", "Monster", "", "monster_lounge.png","","undead"],
	The_Dragon_Lair: #tehty
		["Room", 4, "The Dragon Lair", "Monster", "if you kill a hero in this room, get 1 gold", "dragon_lair.png","","beast"],
	Pit_Fall: #tehty oikee art
		["Room", 1, "Pit Fall", "Trap", "Kill the hero in this room", "pit_fall.png","hero_death_pit.wav"],
	Spike_Trap : #tehty oikee art
		["Room", 3, "Spike Trap", "Trap", "Deal 6 damage to the hero in this room","spikes.png","trap_spikes.wav"],
	Forgotten_Library:
		["Room",3, "Forgotten Library", "Trap","Once in a turn when a hero dies in this room, get a spell card", "forgotten_library.png"],
	Succubus : #tehty oikee art
		["Room", 3, "Succubus", "Monster", "","succubus.png","","undead"],
	Vampire : #tehty oikee art
		["Room", 5, "Vampire", "Monster", "Deals double damage to clerics","vampire.png","","humanoid"],
	Stinky_Ghoul : #tehty oikee art
		["Room", 3, "Stinky Ghoul", "Monster", "","stinky_ghoul.png","","undead"],
	Misunderstood_Ghost : #tehty oikee art
		["Room", 3, "Misunderstood Ghost", "Monster", "","misunderstood_ghost.png","","undead"],
	Zombie_Graveyard : #tehty oikee art
		["Room", 3, "Zombie Graveyard", "Monster", "","zombie_graveyard.png","","undead"],
	Rolling_Golem:
		["Room", 4, "Rolling Golem", "Monster", "","rolling_golem.png","","construct"],
	Killer_Robot:
		["Room", 6, "Killer Robot", "Monster", "Has a 10% chance to self destruct every turn","killer_robot.png","","construct"],
	Angry_Slime:
		["Room", 2, "Angry Slime", "Monster", "hero takes 1 damage for every room they enter","angry_slime.png","","beast"],
	Fire_Elemental:
		["Room", 2, "Fire Elemental", "Monster", "Hero takes 1 damage for every room they enter","fire_elemental.png","","construct"],
	Imp:
		["Room", 2, "Demonic Scout", "Monster", "Heroes that pass this room take +1 dmg from “Demon” type Rooms","imp.png","","demon"],
	Warlock_Summoner:
		["Room", 2, "Warlock Summoner", "Monster", "Your 'Demon' type rooms deal +2dmg","","","demon"],
	Demon_Spawn:
		["Room", 2, "Demon Spawn", "Monster", "has +3dmg if you have a “Lesser devil” in your dungeon","","","demon"],
	Lesser_Devil:
		["Room", 2, "Lesser Devil", "Monster", "","","demon"],
	Outlaw:
		["Room", 2, "Outlaw", "Monster", "takes 2 gold every turn, if at 0 gold, destroy this","","","humanoid"],
	Orc_Bodyguard:
		["Room", 2, "Orc Bodyguard", "Monster", "Gives +2dmg to Goblins but takes 1 per turn, if you have 0 gold, destroy this","","humanoid"],
	Goblin_Army:
		["Room", 2, "Goblin Army", "Monster", "has a 50% chance to get extra +1 gold from killed heroes","","","humanoid"],
	Pack_of_Wolves:
		["Room", 2, "Pack Of Wolves", "Monster", "Has +2dmg for each wolf pack in your dungeon","","","beast"],
	Chihu:
		["Room", 2, "Chihu", "Monster", "Does 1-6 dmg changing every turn","","","beast"],
	Lions_Den:
		["Room", 2, "Lions Den", "Monster", "Must kill a hero within  5 days or gets destroyed","","","beast"],
	Electric_Anomaly:
		["Room", 2, "Electric Anomaly", "Monster", "gives +2 dmg to your “Construct” and “Trap” Rooms","","","construct"],
} 

#Kortit joille on art tehty:
#Healing Potion, Gas Leak, Assassination, pit fall
