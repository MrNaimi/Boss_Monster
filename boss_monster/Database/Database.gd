
#HeroInfo =[Type, Factor, Hp, , Name, Role, Artifact, Special Text]
#BossInfo =[Type, Health, Name, Special Text]
#SpellInfo =[Type, Damage, +Health, Name, Special Text, png]
#RoomInfo =[Type, Damage, Name, Monster or Trap, Special Text, png]

enum {Cleric,Paladin, Monk, Barbarian, Mage, Ranger, Lucky_Fellow, Skeleton_King, Lich, Big_Snake, Shrink_Ray, Corrupted_Mage, Mind_Control, Healing_potion, Assassination, Bad_Directions, Goblin_warrior, Gas_Leak, Mimic, The_Vault_Room, Spike_Factory, Hot_Coals, Monster_Lounge,The_Dragon_Lair, Pit_Fall, Spike_Trap, Forgotten_Library, Succubus}

const DATA ={
	
	#Hero
	Cleric :
		["Hero", 1,7, 9 ,"cleric", "Healer", "Holy_Item", ""],
	Paladin :
		["Hero", 1,14, 17, "paladin", "Damage", "Holy_Item", ""],
	Monk :
		["Hero", 1,10, 13, "monk", "Healer", "Magic_Item", ""],
	Barbarian :
		["Hero", 3, 30,39, "barbarian", "Healer", "Weapon_Item", ""],
	Mage :
		["Hero", 5,50, 55, "mage", "Damage", "Magic_Item", ""],
	Ranger :
		["Hero", 4,40, 48, "ranger", "Damage", "Weapon_item", ""],
	Lucky_Fellow :
		["Hero", 1,9, 10, "lucky_fellow", "Damage", "all", ""],
		
		
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
		["Spell","50%", 0, "Shrink Ray", "Reduce heros maximum HP by 5","std.png"],
	Mind_Control :
		["Spell",100 , 0, "Mind Control", "Targeted Hero deals damage to an adjacent hero","mind_control.png"],
	Healing_potion :
		["Spell","+10hp", 4, "Healing Potion", "Restore 4 health to your Boss","healing_potion.png"],
	Assassination :
		["Spell", 100, 0, "Assassination", "Kill a targeted hero","assassination.png"],
	Bad_Directions :
		["Spell", 100, 0, "Bad Directions", "Return a hero back to the start of the dungeon","bad_directions.png"],
		
	#Rooms 
	Goblin_warrior : #tehty oikee art
		["Room", 3, "Goblin Warrior", "Monster", "", "goblin_warrior.png","goblin_warrior.wav"],
	Gas_Leak : #tehty oikee art
		["Room", 2, "Gas Leak", "Trap", "Deals 1 damage to all heroes", "gas_Leak.png"],
	Mimic :#tehty oikee art
		["Room", 3, "Mimic", "Monster", "", "mimic.png","mimic.wav"],
	The_Vault_Room : #tehty 
		["Room", 3, "The Vault Room","Monster", "", "vault_room.png","vault.wav"],
	Spike_Factory :#tehty
		["Room", 4, "Spike Factory","Monster","", "spike_factory.png"],
	Hot_Coals: #tehty oikee art
		["Room", 3, "Hot Coals","Trap","", "hot_coals.png"],
	Monster_Lounge: #tehty
		["Room", 4, "Monster Lounge", "Monster", "", "monster_lounge.png"],
	The_Dragon_Lair: #tehty
		["Room", 4, "The Dragon Lair", "Monster", "", "dragon_lair.png",""],
	Pit_Fall: #tehty oikee art
		["Room", 1, "Pit Fall", "Trap", "Kill the hero in this room", "pit_fall.png","hero_death_pit.wav"],
	Spike_Trap : #tehty oikee art
		["Room", 3, "Spike Trap", "Trap", "Deal 6 damage to the hero in this room","spikes.png","trap_spikes.wav"],
	Forgotten_Library:
		["Room",3, "Forgotten Library", "Trap","Once in a turn when a hero dies in this room, get a spell card", "forgotten_library.png"],
	Succubus : #tehty oikee art
		["Room", 3, "Succubus", "Monster", "","succubus.png",""],
} 
#Kortit joille on art tehty:
#Healing Potion, Gas Leak, Assassination, pit fall
