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
	else:
		#Shrink Ray, Mind Control, Healing Potion, Assassination, Bad Directions
		for target in card_ui.targets:
			if target.get_parent().get_parent().name=="Hero" && card_ui.card_name.text!="Healing Potion":
				var hero = target.get_parent().get_parent()
				match card_ui.card_name.text:
					"Shrink Ray":
						print("Shrink Ray")
						hero.hp-=int(card_ui.room_dmg.text)
					"Mind Control":
						print("mind control")
						hero.hp-=int(card_ui.room_dmg.text)
					"Assassination":
						print("assassination")
						hero.hp-=int(card_ui.room_dmg.text)
					"Bad Directions":
						hero.hp-=int(card_ui.room_dmg.text)
						print("Bad direction")
				GlobalVariables.actionsLeft-=1
				card_ui.queue_free()
			elif target.get_parent().name=="Boss": 
				print(target.get_parent().get_parent().bossHp)
				print("osuu bossiin :)")
		
func on_input(_event: InputEvent) -> void:
	if played:
		return
	GlobalVariables.card_dragging=false
	transition_requested.emit(self, CardState.State.BASE)

func _on_card_ui_reset_card() -> void:
	#print("doing this in release script")
	GlobalVariables.card_dragging=false
	transition_requested.emit(self, CardState.State.BASE)
