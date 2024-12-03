extends Control

@onready var info: Label = $ColorRect/info
@onready var message_timer: Timer = $messageTimer
var timer_started = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if GlobalVariables.show_card:
		if GlobalVariables.message_sent:
			if !timer_started:
				message_timer.start()
				timer_started=true
			info.text = GlobalVariables.card_info[0]
		else:
			info.text = GlobalVariables.card_info[0] + "\n\n" + "Type: " + GlobalVariables.card_info[1][0].to_upper()+GlobalVariables.card_info[1].substr(1,-1)
		visible = true
	else:
		visible = false
	
	
func _on_message_timer_timeout() -> void:
	GlobalVariables.show_card = false
	timer_started=false
	GlobalVariables.message_sent=false
