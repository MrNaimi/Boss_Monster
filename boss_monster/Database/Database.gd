
#HeroInfo =[Type, Damage, Health, Name, Role, Artifact, Special Text]
#BossInfo =[Type, Health, Name, Special Text]
#SpellInfo =[Type, Damage, +Health, Name, Special Text]
#RoomInfo =[Type, Damage, Name, Monster or Trap, Special Text]

enum {Cleric,Paladin, Monk, Barbarian, Mage, Ranger, Lucky_Fellow, Skeleton_King, Lich, Big_Snake, Shrink_Ray, Corrupted_Mage, Mind_Control, Healing_potion, Assassination, Bad_Directions, Goblin_warrior, Gas_Leak, Mimic, The_Vault_Room, Spike_Factory, Hot_Coals, Monster_Lounge,}

const DATA ={
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
	Skeleton_King :
		["Boss", 20, "Skeleton_King", "Wants to raise an army of smaller and smaller skeletons"],
	Lich :
		["Boss"],
	Big_Snake :
		["Boss"],
	Corrupted_Mage: 
		["Boss", 20, "Corrupted_Mage", "Will not rest until he has the strongest magic!"],
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
	Goblin_warrior :
		["Room", 3, "Goblin Warrior", "Monster", ""],
	Gas_Leak :
		["Room", 2, "Gas Leak", "Trap", "Deals 1 damage to all heroes"],
	Mimic :
		["Room", 3, "Mimic", "Monster", ""],
	The_Vault_Room :
		["Room", 3, "The Vault Room","Monster", ""],
	Spike_Factory :
		["Room",4, "Spike Factory","Trap",""],
	Hot_Coals:
		["Room",3, "Hot Coals","Trap",""],	
	Monster_Lounge:
		["Room",4, "Monster Lounge", "Monster", ""],	
} 
