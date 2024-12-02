extends CardState

var played: bool

func enter() -> void:
	

	#card_ui.drop_point_detecor.get_child(0) = true
	played = false
	if card_ui.room_type.text != "S" && !card_ui.shop_card:
		if not card_ui.targets.is_empty() && card_ui.targets[0].name == "sellAreasize":
				GlobalVariables.player_gold+=5
				card_ui.visible=false
		elif not card_ui.targets.is_empty() && card_ui.targets[0].get_child(0).get_child(0).get_child_count() == 0:
			
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
			var trapName = card_ui.card_name.text
			
			#print(GlobalVariables.ConstructDmgBuff)
			#print(GlobalVariables.BeastDmgBuff)
			#print(GlobalVariables.HumanoidDmgBuff)
			#print(GlobalVariables.DemonDmgBuff)
			#print(GlobalVariables.SpikeTrapDmgBuff)
			match trapName:
				"Electric Anomaly":
					GlobalVariables.ConstructDmgBuff+=2
					print(GlobalVariables.ConstructDmgBuff)
				"Pack Of Wolves":
					GlobalVariables.BeastDmgBuff+=2
					print(GlobalVariables.BeastDmgBuff)
				"Orc Bodyguard":
					GlobalVariables.HumanoidDmgBuff+=2
					print(GlobalVariables.HumanoidDmgBuff)
				"Warlock Summoner":
					GlobalVariables.DemonDmgBuff+=2
					print(GlobalVariables.DemonDmgBuff)
				"Spike Factory":
					GlobalVariables.SpikeTrapDmgBuff+=2
					print(GlobalVariables.SpikeTrapDmgBuff)
	elif card_ui.shop_card:
		print("hellooo")
		if not card_ui.targets.is_empty() && card_ui.targets[0].name=="CardBuyArea" && card_ui.targets[0].get_parent().get_child_count()<6:
			print("nyt voisin ostaa tämän kortin :))))")
			GlobalVariables.cardData=card_ui.selectedRoom
			GlobalVariables.cardBought = true
			GlobalVariables.createCard = true
			print(GlobalVariables.cardData)
			card_ui.visible = false
	else:
		#Shrink Ray, Mind Control, Healing Potion, Assassination, Bad Directions
		for target in card_ui.targets:
			if target.get_parent().get_parent().name=="Hero" && card_ui.card_name.text!="Healing Potion":
				var hero = target.get_parent().get_parent()
				match card_ui.card_name.text:
					"Shrink Ray":
						print("Shrink Ray")
						hero.hp= floor(hero.hp/2)
						target.get_parent().scale.x=1
						target.get_parent().scale.y=1
					"Mind Control":
						if hero.can_move:
							print("mind control")
							hero.can_move = false
							hero.flipped = true
							hero.mindcontrolled = true
							hero.get_child(0).damage = hero.hp
							if GlobalVariables.amount_of_heroes_alive == 1:
								GlobalVariables.spawn_hero = true
						else:
							break
						#hero.hp-=int(card_ui.room_dmg.text)
					"Assassination":
						print("assassination")
						hero.hp-=int(card_ui.room_dmg.text)
					"Bad Directions":
						hero.path_direction = -1
						hero.flipped = true
						hero.get_child(0).flip_h = not hero.get_child(0).flip_h 
						print("Bad direction")
						
				GlobalVariables.actionsLeft-=1
				card_ui.queue_free()
			elif target.get_parent().name=="Boss": 
				print(target.get_parent().get_parent().boss_hp)
				print("osuu bossiin :)")
				if target.get_parent().get_parent().hp<=40:
					target.get_parent().get_parent().hp+=10
				else:
					target.get_parent().get_parent().hp=50
				target.get_parent().get_parent().refreshHP()
				card_ui.queue_free()
			#GlobalVariables.created_spells-=1
			
func on_input(_event: InputEvent) -> void:
	if played:
		return
	GlobalVariables.card_dragging=false
	transition_requested.emit(self, CardState.State.BASE)

func _on_card_ui_reset_card() -> void:
	#print("doing this in release script")
	GlobalVariables.card_dragging=false
	transition_requested.emit(self, CardState.State.BASE)
