extends Control

@onready var info: Label = $ColorRect/info
@onready var message_timer: Timer = $messageTimer
var timer_started = false
@onready var destroy_room: Button = $ColorRect/destroy_room
@onready var color_rect: ColorRect = $ColorRect
var undead_rooms_destroyed = 0
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:

		
	if GlobalVariables.show_card:
		if GlobalVariables.message_sent:
			if !timer_started:
				message_timer.start()
				timer_started=true
			info.text = GlobalVariables.card_info[0]
		else:
			if !timer_started:
				message_timer.wait_time = 10
				message_timer.start()
				timer_started = true
			
			info.text = GlobalVariables.card_info[0] + "\n" + "Type: " + GlobalVariables.card_info[1][0].to_upper()+GlobalVariables.card_info[1].substr(1,-1)+ "\n" + "Base damage: " + str(GlobalVariables.card_info[2])
		visible = true
	else:
		visible = false
		
	if GlobalVariables.destroy_room && GlobalVariables.room_to_be_destroyed != null:
		destroy_room.visible=true
		message_timer.wait_time=10
		if !timer_started:
			message_timer.start()
			timer_started=true
	else:
		destroy_room.visible=false
	
func _on_message_timer_timeout() -> void:
	GlobalVariables.show_card = false
	timer_started=false
	GlobalVariables.message_sent=false
	message_timer.wait_time=10

func _on_destroy_room_pressed() -> void:
	GlobalVariables.rooms_destroyed += 1
	var trapName = GlobalVariables.room_to_be_destroyed.card_name.text
	match trapName:
		"Electric Anomaly":
			GlobalVariables.ConstructDmgBuff-=2
			GlobalVariables.TrapDmgBuff-=2
			print(GlobalVariables.ConstructDmgBuff)
		"Lions Den":
			GlobalVariables.lions_dens_in_the_dungeon -= 1
			print(GlobalVariables.BeastDmgBuff)
		"Orc Bodyguard":
			GlobalVariables.HumanoidDmgBuff-=2
			GlobalVariables.orc_bodyguards_in_dungeon -= 1
			print(GlobalVariables.HumanoidDmgBuff)
		"Warlock Summoner":
			GlobalVariables.DemonDmgBuff-=2
			print(GlobalVariables.DemonDmgBuff)
		"Spike Factory":
			GlobalVariables.SpikeTrapDmgBuff-=2
			print(GlobalVariables.SpikeTrapDmgBuff)
		"Goblin Warrior":
			print("goblin warrior tuhottu")
			GlobalVariables.goblin_warriors_in_dungeon-=1
		"Stinky Ghoul":
			undead_rooms_destroyed+=1
			GlobalVariables.TrapDmgBuff += 2
			GlobalVariables.DemonDmgBuff += 2
			GlobalVariables.HumanoidDmgBuff += 2
			GlobalVariables.BeastDmgBuff += 2
			GlobalVariables.ConstructDmgBuff += 2
			GlobalVariables.SpikeTrapDmgBuff += 2
		"Lesser Devil":
			GlobalVariables.lesser_devils_in_dungeon -= 1
		"Outlaw":
			GlobalVariables.outlaws_in_dungeon -= 1
		"Goblin Army":
			GlobalVariables.goblin_armies_in_dungeon -= 1
		"Chihu":
			GlobalVariables.beast_rooms_in_dungeon-=1
		"Pack of Wolves":
			GlobalVariables.pack_of_wolves_placed -= 1
			GlobalVariables.beast_rooms_in_dungeon-=1
		"Angry Slime":
			GlobalVariables.beast_rooms_in_dungeon-=1
		"Dragon Lair":
			GlobalVariables.beast_rooms_in_dungeon-=1
		"Killer Robot":
			GlobalVariables.killer_robot_placed = false
		"Skeleton Lounge":
			undead_rooms_destroyed+=1
			GlobalVariables.UndeadDmgBuff+=1
		"Repair Bot":
			GlobalVariables.repair_bots-=1
		"Misunderstood Ghost":
			undead_rooms_destroyed+=1
			GlobalVariables.misunderstood_ghosts-=1
		"Stinky Ghoul":
			undead_rooms_destroyed+=1
			GlobalVariables.stinky_ghouls-=1
		"Succubus":
			GlobalVariables.succubi_placed-=1
		"Summoning Circle":
			GlobalVariables.summoning_circles-=1
		"Skeleton CEO":
			undead_rooms_destroyed+=1
		"The Last Mammoth":
			GlobalVariables.beast_rooms_in_dungeon-=1
		"Ominous Shadow":
			GlobalVariables.shadows -= 1
			if GlobalVariables.stinky_ghouls>0 && GlobalVariables.misunderstood_ghosts>0 && GlobalVariables.shadows == 0:
				GlobalVariables.UndeadDmgBuff-=5
				GlobalVariables.shadow_buff_given = false
		"Gator":
			GlobalVariables.beast_rooms_in_dungeon-=1
		"Summoning Circle":
			GlobalVariables.demon_rooms_placed-=1
		"Goblin General":
			GlobalVariables.goblin_generals_in_dung -= 1
	if undead_rooms_destroyed>=1:
		for lounge in GlobalVariables.skeleton_lounges:
			lounge.card_ui.damage+=1
		undead_rooms_destroyed-=1
		
	print("Construct Damage Buff:", GlobalVariables.ConstructDmgBuff)
	print("Beast Damage Buff:", GlobalVariables.BeastDmgBuff)
	print("Humanoid Damage Buff:", GlobalVariables.HumanoidDmgBuff)
	print("Demon Damage Buff:", GlobalVariables.DemonDmgBuff)
	print("Spike Trap Damage Buff:", GlobalVariables.SpikeTrapDmgBuff)

	
	GlobalVariables.room_to_be_destroyed.queue_free()
	GlobalVariables.show_card = false
	GlobalVariables.room_to_be_destroyed = null
	GlobalVariables.destroy_room=false

		


func _on_button_pressed() -> void:
	GlobalVariables.show_card = false
