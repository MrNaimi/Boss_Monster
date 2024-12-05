extends CardState

const DRAG_MINIMUM_THRESHOLD := 0.05
var minimum_drag_time_elapsed := false

func enter() -> void:
	var ui_layer := get_tree().get_first_node_in_group("ui_layer")
	if ui_layer:
		card_ui.reparent(ui_layer)
	if !card_ui.shop_card:
		if card_ui.room_type.text=="S":
			GlobalVariables.spell_dragging= true
		else:
			GlobalVariables.card_dragging = true
	else:
		print("nyt raahataan shop cardia")
		GlobalVariables.shop_card_dragging = true
	#card_ui.color.color= Color.NAVY_BLUE
	#card_ui.state.text = ""
	
	minimum_drag_time_elapsed = false
	var threshold_timer := get_tree().create_timer(DRAG_MINIMUM_THRESHOLD, false)
	threshold_timer.timeout.connect(func(): minimum_drag_time_elapsed = true)
	
func on_input(event: InputEvent) -> void:
	var mouse_motion := event is InputEventMouseMotion
	var cancel = event.is_action_pressed("mmb")
	var confirm = event.is_action_released("click") or event.is_action_pressed("click")	
	
	if mouse_motion:
		card_ui.global_position = card_ui.get_global_mouse_position() - card_ui.pivot_offset
	if cancel:
		GlobalVariables.show_card = true
		GlobalVariables.card_dragging=false
		GlobalVariables.spell_dragging=false
		GlobalVariables.shop_card_dragging = false
		transition_requested.emit(self, CardState.State.BASE)
	elif minimum_drag_time_elapsed and confirm:
		get_viewport().set_input_as_handled()
		transition_requested.emit(self, CardState.State.RELEASED)
	

		
