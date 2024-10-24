
#HeroInfo =[Type, Damage, Health, Name, Role, Artifact, Special Text]
#BossInfo =[Type, Health, Name, Special Text]
#SpellInfo =[Type, Damage, +Health, Name, Special Text]
#RoomInfo =[Type, Damage, Name, Monster or Trap, Special Text]

enum {Cleric,Paladin, Monk, Barbarian, Mage, Ranger, Lucky_Fellow, Skeleton_King, Lich, Big_Snake, Shrink_Ray, Corrupted_Mage, Mind_Control, Healing_potion, Assassination, Bad_Directions, Goblin_warrior, Gas_Leak, Mimic, The_Vault_Room, Spike_Factory, Hot_Coals, Monster_Lounge,The_Dragon_Lair, Pit_Fall, Spike_Trap,}

const DATA ={
	
	#Hero
	Cleric :
		["Hero", 2, 4 ,"Cleric", "Healer", "Holy_Item", ""],
	Paladin :
		["Hero", 3, 6, "Paladin", "Damage", "Holy_Item", ""],
	Monk :
		["Hero", 2, 4, "Monk", "Healer", "Magic_Item", ""],
	Barbarian :
		["Hero", 4, 8, "Barbarian", "Healer", "Weapon_Item", ""],
	Mage :
		["Hero", 6, 4, "Mage", "Damage", "Magic_Item", ""],
	Ranger :
		["Hero", 4, 5, "Ranger", "Damage", "Weapon_item", ""],
	Lucky_Fellow :
		["Hero", 1, 2, "Lucky_Fellow", "Damage", "all", ""],
		
		
	#Boss
	Skeleton_King :
		["Boss", 20, "Skeleton_King", "Wants to raise an army of smaller and smaller skeletons"],
	Lich :
		["Boss"],
	Big_Snake :
		["Boss"],
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
	Goblin_warrior :
		["Room", 3, "Goblin Warrior", "Monster", ""],
	Gas_Leak :
		["Room", 2, "Gas Leak", "Trap", "Deals 1 damage to all heroes"],
	Mimic :
		["Room", 3, "Mimic", "Monster", ""],
	The_Vault_Room :
		["Room", 3, "The Vault Room","Monster", ""],
	Spike_Factory :
		["Room", 4, "Spike Factory","Trap",""],
	Hot_Coals:
		["Room", 3, "Hot Coals","Trap",""],
	Monster_Lounge:
		["Room", 4, "Monster Lounge", "Monster", ""],
	The_Dragon_Lair: 
		["Room", 4, "The Dragon Lair", "Monster", ""],
	Pit_Fall:
		["Room", 1, "Pit Fall", "Trap", "Kill the hero in this room"],
	Spike_Trap :
		["Room", 3, "Spike Trap", "Trap", "Deal 6 damage to the hero in this room"],
} 
#Kortit joille on art tehty:
#Healing Potion, Gas Leak, Assassination
