extends CardState

var played: bool

func enter() -> void:
	

	#card_ui.drop_point_detecor.get_child(0) = true
	played = false
	if card_ui.room_type.text != "S" && !card_ui.shop_card:
		if not card_ui.targets.is_empty() && card_ui.targets[0].name == "sellAreasize":
				GlobalVariables.player_gold+=5
				card_ui.visible=false
				GlobalVariables.card_dragging = false

		elif not card_ui.targets.is_empty() && card_ui.targets[0].name != "CardBuyArea":
			if card_ui.targets[0].get_child(0).get_child(0).get_child_count() == 0:
				GlobalVariables.rooms_placed.append(card_ui)
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
				#card_ui.room_dmg_2.visible = true
				
				card_ui.placed = true
				played = true
				print(get_parent())
				card_ui.reparent(card_ui.targets[0].get_child(0).get_child(0))
				GlobalVariables.rooms_placed_num+=1
				for room in GlobalVariables.rooms_placed:
					if is_instance_valid(room):
						room.spawn_room=false
				GlobalVariables.spawn_room_set=false
				
				#print(GlobalVariables.ConstructDmgBuff)
				#print(GlobalVariables.BeastDmgBuff)
				#print(GlobalVariables.HumanoidDmgBuff)
				#print(GlobalVariables.DemonDmgBuff)
				#print(GlobalVariables.SpikeTrapDmgBuff)
				var trapName = card_ui.card_name.text

				match trapName:
					"Electric Anomaly":
						GlobalVariables.ConstructDmgBuff+=2
						GlobalVariables.TrapDmgBuff+=2
						print(GlobalVariables.ConstructDmgBuff)
					"Lions Den":
						GlobalVariables.lions_dens_in_the_dungeon += 1
						GlobalVariables.beast_rooms_in_dungeon+=1
						print(GlobalVariables.BeastDmgBuff)
					"Orc Bodyguard":
						
						GlobalVariables.HumanoidDmgBuff+=2
						GlobalVariables.orc_bodyguards_in_dungeon += 1
						GlobalVariables.orc_bodyguards.append(self)
						#print(GlobalVariables.HumanoidDmgBuff)
					"Warlock Summoner":
						GlobalVariables.demon_rooms_placed += 0.5
						GlobalVariables.DemonDmgBuff+=2
						#print(GlobalVariables.DemonDmgBuff)
					"Spike Factory":
						GlobalVariables.SpikeTrapDmgBuff+=3
						#print(GlobalVariables.SpikeTrapDmgBuff)
					"Goblin Warrior":
						GlobalVariables.goblin_warriors_in_dungeon += 1
						
					"Stinky Ghoul":
						GlobalVariables.stinky_ghouls+=1
						GlobalVariables.TrapDmgBuff -= 2
						GlobalVariables.DemonDmgBuff -= 2
						GlobalVariables.HumanoidDmgBuff -= 2
						GlobalVariables.BeastDmgBuff -= 2
						GlobalVariables.ConstructDmgBuff -= 2
						GlobalVariables.SpikeTrapDmgBuff -= 2
					"Lesser Devil":
						GlobalVariables.demon_rooms_placed += 0.5
						GlobalVariables.lesser_devils_in_dungeon += 1
					"Demon Spawn":
						GlobalVariables.demon_rooms_placed += 0.5
					"Demonic Scout":
						GlobalVariables.demon_rooms_placed += 0.5
					"Succubus":
						GlobalVariables.demon_rooms_placed += 0.5
						GlobalVariables.succubi_placed += 1
					"Outlaw":
						GlobalVariables.outlaws_in_dungeon += 1
						GlobalVariables.outlaws.append(self)
					"Goblin Army":
						GlobalVariables.goblin_army_active = true
					"Chihu":
						GlobalVariables.beast_rooms_in_dungeon+=1
					"Pack of Wolves":
						GlobalVariables.pack_of_wolves_placed += 1
						GlobalVariables.beast_rooms_in_dungeon+=1
					"Angry Slime":
						GlobalVariables.beast_rooms_in_dungeon+=1
					"Dragon Lair":
						GlobalVariables.beast_rooms_in_dungeon+=1
					"Killer Robot":
						GlobalVariables.killer_robot_placed = true
					"Repair Bot":
						GlobalVariables.repair_bots+=1
					"Misunderstood Ghost":
						GlobalVariables.misunderstood_ghosts+=1
					"Summoning Circle":
						GlobalVariables.summoning_circles+=1
	elif card_ui.shop_card:
		print("hellooo")
		if not card_ui.targets.is_empty() && card_ui.targets[0].name=="CardBuyArea" && card_ui.targets[0].get_parent().get_child_count()<6 && GlobalVariables.player_gold>=10:
			print("nyt voisin ostaa tämän kortin :))))")
			GlobalVariables.cardData=card_ui.selectedRoom
			GlobalVariables.cardBought = true
			GlobalVariables.createCard = true
			print(GlobalVariables.cardData)
			card_ui.visible = false
			GlobalVariables.player_gold-=10
		else:
			GlobalVariables.message("Hand is full",false)
	else:
		#Shrink Ray, Mind Control, Healing Potion, Assassination, Bad Directions
		for target in card_ui.targets:
			if target.get_parent().get_parent().name=="Hero" && card_ui.card_name.text!="Healing Potion":
				var hero = target.get_parent().get_parent()
				match card_ui.card_name.text:
					"Shrink Ray":
						print("Shrink Ray")
						GlobalVariables.damage_done+=floor(hero.hp/2)
						hero.hp= floor(hero.hp/2)
						
						target.get_parent().scale.x=1
						target.get_parent().scale.y=1
					"Mind Control":
						if hero.can_move && GlobalVariables.amount_of_heroes_alive>1:
							print("mind control")
							hero.can_move = false
							hero.flipped = true
							hero.mindcontrolled = true
							hero.get_child(0).damage = hero.hp
						else:
							GlobalVariables.message("There has to be more than one hero in the dungeon, and it has to be moving",false)
							break
						#hero.hp-=int(card_ui.room_dmg.text)
					"Assassination":
						print("assassination")
						GlobalVariables.damage_done+=int(card_ui.room_dmg.text)
						hero.hp-=int(card_ui.room_dmg.text)
						if GlobalVariables.amount_of_heroes_alive==1:
							GlobalVariables.spawn_hero=true
							
					"Bad Directions":
						hero.path_direction = -1
						hero.flipped = true
						hero.get_child(0).flip_h = not hero.get_child(0).flip_h 
						print("Bad direction")
						
				#GlobalVariables.actionsLeft-=1
				#GlobalVariables.created_spells-=1
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

func on_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("click") or event.is_action_pressed("rightclick"):
		#GlobalVariables.card_info[1] = card_ui.tribe
		GlobalVariables.placed_message(card_ui.card_info,card_ui.tribe,true,card_ui,card_ui.damage)
	
