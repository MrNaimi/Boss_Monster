
#HeroInfo =[Type, Damage, Health, Name, Role, Artifact, Special Text]
#BossInfo =[Type, Health, Name, Special Text]
#SpellInfo =[Type, Damage, +Health, Name, Special Text]
#RoomInfo =[Type, Damage, Name, Monster or Trap, Special Text]

enum {Cleric,Paladin, Monk, Barbarian, Mage, Ranger, Lucky_Fellow, Skeleton_King, Lich, Big_Snake, Shrink_Ray, Mind_Control, Healing_potion, Goblin_warrior, Gas_Leak}

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
	Shrink_Ray :
		["Spell",],
	Mind_Control :
		["Spell",0 , 0, "Mind Control", "Targeted Hero deals damage to an adjacent hero"],
	Healing_potion :
		["Spell",0, 4, "Healing Potion", ],
	Goblin_warrior :
		["Room", 3, "Goblin Warrior", "Monster", ""],
	Gas_Leak :
		["Room", 2, "Gas Leak", "Trap", "Deals 1 damage to all heroes"],
}
