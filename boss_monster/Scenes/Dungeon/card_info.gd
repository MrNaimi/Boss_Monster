extends Control

@onready var info: Label = $ColorRect/info
@onready var message_timer: Timer = $messageTimer
var timer_started = false
@onready var destroy_room: Button = $ColorRect/destroy_room
@onready var color_rect: ColorRect = $ColorRect

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if GlobalVariables.show_card:
		if GlobalVariables.message_sent:
			if !timer_started:
				message_timer.start()
				timer_started=true
			info.text = GlobalVariables.card_info[0]
		else:
			info.text = GlobalVariables.card_info[0] + "\n" + "Type: " + GlobalVariables.card_info[1][0].to_upper()+GlobalVariables.card_info[1].substr(1,-1)+ "\n" + "Base damage: " + str(GlobalVariables.card_info[2])
		visible = true
	else:
		visible = false
	if GlobalVariables.destroy_room:
		destroy_room.visible=true
		message_timer.wait_time=3.0
		if !timer_started:
			message_timer.start()
			timer_started=true
	else:
		destroy_room.visible=false
	
func _on_message_timer_timeout() -> void:
	GlobalVariables.show_card = false
	timer_started=false
	GlobalVariables.message_sent=false
	message_timer.wait_time=1.5

func _on_destroy_room_pressed() -> void:
	var trapName = GlobalVariables.room_to_be_destroyed.card_name.text
	match trapName:
		"Electric Anomaly":
			GlobalVariables.ConstructDmgBuff-=2
			GlobalVariables.TrapDmgBuff+=2
			print(GlobalVariables.ConstructDmgBuff)
		"Lions Den":
			GlobalVariables.BeastDmgBuff-=2
			print(GlobalVariables.BeastDmgBuff)
		"Orc Bodyguard":
			GlobalVariables.HumanoidDmgBuff-=2
			print(GlobalVariables.HumanoidDmgBuff)
		"Warlock Summoner":
			GlobalVariables.DemonDmgBuff-=2
			print(GlobalVariables.DemonDmgBuff)
		"Spike Factory":
			GlobalVariables.SpikeTrapDmgBuff-=2
			print(GlobalVariables.SpikeTrapDmgBuff)

	print("Construct Damage Buff:", GlobalVariables.ConstructDmgBuff)
	print("Beast Damage Buff:", GlobalVariables.BeastDmgBuff)
	print("Humanoid Damage Buff:", GlobalVariables.HumanoidDmgBuff)
	print("Demon Damage Buff:", GlobalVariables.DemonDmgBuff)
	print("Spike Trap Damage Buff:", GlobalVariables.SpikeTrapDmgBuff)

	
	GlobalVariables.room_to_be_destroyed.queue_free()
	GlobalVariables.show_card = false
	GlobalVariables.room_to_be_destroyed = null
	GlobalVariables.destroy_room=false
	
