
#HeroInfo =[Type, Factor, Hp, , Name, Role, Artifact, Special Text]
#BossInfo =[Type, Health, Name, Special Text]
#SpellInfo =[Type, Damage, +Health, Name, Special Text]
#RoomInfo =[Type, Damage, Name, Monster or Trap, Special Text, png]

enum {Cleric,Paladin, Monk, Barbarian, Mage, Ranger, Lucky_Fellow, Skeleton_King, Lich, Big_Snake, Shrink_Ray, Corrupted_Mage, Mind_Control, Healing_potion, Assassination, Bad_Directions, Goblin_warrior, Gas_Leak, Mimic, The_Vault_Room, Spike_Factory, Hot_Coals, Monster_Lounge,The_Dragon_Lair, Pit_Fall, Spike_Trap,}

const DATA ={
	
	#Hero
	Cleric :
		["Hero", 2,0, 4 ,"cleric", "Healer", "Holy_Item", ""],
	Paladin :
		["Hero", 3,0, 6, "paladin", "Damage", "Holy_Item", ""],
	Monk :
		["Hero", 2,0, 4, "monk", "Healer", "Magic_Item", ""],
	Barbarian :
		["Hero", 4, 0,8, "barbarian", "Healer", "Weapon_Item", ""],
	Mage :
		["Hero", 12,0, 36, "mage", "Damage", "Magic_Item", ""],
	Ranger :
		["Hero", 4,0, 5, "ranger", "Damage", "Weapon_item", ""],
	Lucky_Fellow :
		["Hero", 1,0, 2, "lucky_fellow", "Damage", "all", ""],
		
		
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
		["Spell",0,0, "Shrink Ray", "Reduce heros maximum HP by 5"],
	Mind_Control :
		["Spell",0 , 0, "Mind Control", "Targeted Hero deals damage to an adjacent hero"],
	Healing_potion :
		["Spell",0, 4, "Healing Potion", "Restore 4 health to your Boss"],
	Assassination :
		["Spell", 100, 0, "Assassination", "Kill a targeted hero"],
	Bad_Directions :
		["Spell", 0, 0, "Bad Directions", "Return a hero back to the start of the dungeon"],
		
	#Rooms 
	Goblin_warrior : #tehty oikee art
		["Room", 3, "Goblin Warrior", "Monster", "", "goblin_warrior.png"],
	Gas_Leak : #tehty oikee art
		["Room", 2, "Gas Leak", "Trap", "Deals 1 damage to all heroes", "gas_Leak.png"],	
	Mimic :#tehty oikee art
		["Room", 3, "Mimic", "Monster", "", "mimic.png"],
	The_Vault_Room : #tehty 
		["Room", 3, "The Vault Room","Monster", "", "vault_room.png"],
	Spike_Factory :#tehty
		["Room", 4, "Spike Factory","Monster","", "spike_factory.png"],
	Hot_Coals: #tehty oikee art
		["Room", 3, "Hot Coals","Trap","", "hot_coals.png"],
	Monster_Lounge: #tehty
		["Room", 4, "Monster Lounge", "Monster", "", "monster_lounge.png"],
	The_Dragon_Lair: #tehty
		["Room", 4, "The Dragon Lair", "Monster", "", "dragon_lair.png"],
	Pit_Fall: #tehty oikee art
		["Room", 1, "Pit Fall", "Trap", "Kill the hero in this room", "pit_fall.png"],
	Spike_Trap : #tehty oikee art
		["Room", 3, "Spike Trap", "Trap", "Deal 6 damage to the hero in this room","spikes.png"],
} 
#Kortit joille on art tehty:
#Healing Potion, Gas Leak, Assassination, pit fall
