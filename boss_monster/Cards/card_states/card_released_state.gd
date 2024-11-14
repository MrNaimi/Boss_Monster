extends CardState

var played: bool

func enter() -> void:
	

	#card_ui.drop_point_detecor.get_child(0) = true
	played = false
	if card_ui.room_type.text != "S":
		if not card_ui.targets.is_empty() && card_ui.targets[0].get_child(0).get_child(0).get_child_count() == 0:
			GlobalVariables.actionsLeft-=1
			GlobalVariables.trap_placed=true
			GlobalVariables.card_dragging=false
			card_ui.card_texture.visible=false
			card_ui.color.color = Color.TRANSPARENT
			#card_ui.state.text = ""
			card_ui.trap_texture.visible = true
			card_ui.trap_hit_box.disabled = false
			card_ui.card_border.visible = false
			card_ui.card_name.visible = false
			card_ui.room_type.visible = false
			card_ui.room_dmg.visible = false
			
			played = true
			#print("play card for target(s)", card_ui.targets)
			#print("Child nodes of target area:", card_ui.targets[0].get_child(0).get_children())
			card_ui.reparent(card_ui.targets[0].get_child(0).get_child(0))
			for room in GlobalVariables.rooms_placed:
				room.spawn_room=false
			GlobalVariables.spawn_room_set=false
		
func on_input(_event: InputEvent) -> void:
	if played:
		return
	GlobalVariables.card_dragging=false
	transition_requested.emit(self, CardState.State.BASE)

func _on_card_ui_reset_card() -> void:
	#print("doing this in release script")
	GlobalVariables.card_dragging=false
	transition_requested.emit(self, CardState.State.BASE)
