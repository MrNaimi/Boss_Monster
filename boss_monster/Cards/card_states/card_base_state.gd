extends CardState


func enter() -> void:
	if not card_ui.is_node_ready():
		await card_ui.ready
	GlobalVariables.combat_phase=false
	card_ui.trap_hit_box.disabled = true
	card_ui.card_texture.visible = true
	card_ui.reparent_requested.emit(card_ui)
	card_ui.color.color = Color("77777b")
	card_ui.room_type.visible = true
	card_ui.room_dmg.visible = true
	#card_ui.state.text = ""
	card_ui.pivot_offset = Vector2.ZERO
	card_ui.card_border.visible = true
	card_ui.card_name.visible = true
	 
func on_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("click"):
		card_ui.pivot_offset = card_ui.get_global_mouse_position() - card_ui.global_position
		transition_requested.emit(self, CardState.State.CLICKED)
