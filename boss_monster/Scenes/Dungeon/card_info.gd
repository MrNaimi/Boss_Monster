extends Control

@onready var info: Label = $ColorRect/info


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if GlobalVariables.show_card == true:
		visible = true
		info.text = GlobalVariables.card_info[0] + "\n\n" + "Room type: " + GlobalVariables.card_info[1][0].to_upper()+GlobalVariables.card_info[1].substr(1,-1)
	else:
		visible = false
