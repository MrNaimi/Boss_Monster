extends Control
@onready var sellanimation: AnimationPlayer = $sellanimation

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if GlobalVariables.card_dragging or GlobalVariables.spell_dragging && GlobalVariables.phase == "shop":
		visible=true
		sellanimation.play("sellanimation")
	else:
		visible=false
