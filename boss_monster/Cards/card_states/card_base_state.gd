extends CardState


func enter() -> void:
	if GlobalVariables.show_card == false:
		print("hei")
	if not card_ui.is_node_ready():
		await card_ui.ready
		
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
	GlobalVariables.show_card = false
	
	
	 
		
func on_gui_input(event: InputEvent) -> void:
	if !card_ui.shop_card or GlobalVariables.currentPhase=="build":
		if event.is_action_pressed("click"):
			if GlobalVariables.currentPhase=="build" && GlobalVariables.actionsLeft>0 && card_ui.room_type.text!="S": 
				card_ui.pivot_offset = card_ui.get_global_mouse_position() - card_ui.global_position
				transition_requested.emit(self, CardState.State.CLICKED)
			elif GlobalVariables.currentPhase=="combat" && GlobalVariables.actionsLeft>0 && card_ui.room_type.text=="S":
				card_ui.pivot_offset = card_ui.get_global_mouse_position() - card_ui.global_position
				transition_requested.emit(self, CardState.State.CLICKED)
	if event.is_action_pressed("mmb"):
		if GlobalVariables.card_info == card_ui.card_info && GlobalVariables.show_card:
			GlobalVariables.show_card = false
		else:
			#GlobalVariables.card_info = card_ui.card_info
			#GlobalVariables.message(card_ui.card_info,false)
			GlobalVariables.placed_message(card_ui.card_info,card_ui.tribe,false,null,card_ui.damage)
			#GlobalVariables.card_info[0] = card_ui.card_info
			#GlobalVariables.card_info[1] = card_ui.tribe
			#print(GlobalVariables.card_info[2])
			#GlobalVariables.card_info[2] = card_ui.room_dmg.text
			#GlobalVariables.show_card = true
			#GlobalVariables.destroy_room = false
			#print(card_ui.card_info)
		
			
