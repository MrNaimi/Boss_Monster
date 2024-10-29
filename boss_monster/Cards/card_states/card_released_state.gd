extends CardState

var played: bool

func enter() -> void:
	
	card_ui.color.color = Color.TRANSPARENT
	card_ui.state.text = ""
	card_ui.trap_texture.visible = true
	
	played = false
	
	
	if not card_ui.targets.is_empty() && card_ui.targets[0].get_child(0).get_child(0).get_child_count() == 0:
		played = true
		print("play card for target(s)", card_ui.targets)
		print("Child nodes of target area:", card_ui.targets[0].get_child(0).get_children())
		card_ui.reparent(card_ui.targets[0].get_child(0).get_child(0))
		
func on_input(_event: InputEvent) -> void:
	if played:
		return
		
	transition_requested.emit(self, CardState.State.BASE)
