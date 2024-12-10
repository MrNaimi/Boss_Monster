extends Control
@onready var card: PackedScene = preload("res://Cards/card_ui.tscn")
@onready var sell_area: Control = $SellArea
@onready var sellanimation: AnimationPlayer = $SellArea/sellanimation
@onready var refresh_button: Button = $RefreshButton
@onready var shopcover: ColorRect = $shopcover
@onready var shopanimation: AnimationPlayer = $shopcover/shopanimation
@onready var timer: Timer = $shopcover/Timer
@onready var shophand: ShopHand = $shophand


var shoplimit = 2
var pos = 0
var shopanimplayed = true
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#createCards()
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if GlobalVariables.currentPhase == "build":
		if GlobalVariables.playshopanim:
			shopanimation.play("shophide")
			GlobalVariables.playshopanim = false
			timer.start()
		if (GlobalVariables.card_dragging):
			sell_area.visible=true
			refresh_button.visible=false
			sellanimation.play("sellanimation")
			
		else:
			sell_area.visible=false
			refresh_button.visible=true
	else:
		if GlobalVariables.playshopanim:
			shopcover.visible=true
			shopanimation.play("shopshow")
			GlobalVariables.playshopanim = false
	refresh_button.text = "Refresh: " + str(GlobalVariables.rerollCost) + " gold"
			
func createCards() -> void:
	for child in get_child(0).get_children():
		print(child.get_child_count())
		if child.is_class("HBoxContainer") && child.get_child_count()<shoplimit:
			print("yritetään luoda kortteja kortteja")
			for index in range(shoplimit):
				if child.get_child_count()<2:
					child.add_child(card.instantiate())
				
	shophand.start_state_machine()


func _on_timer_timeout() -> void:
	shopcover.visible=false


func _on_refresh_button_pressed() -> void:
	if GlobalVariables.rerollCost<=GlobalVariables.player_gold:
		GlobalVariables.player_gold-=GlobalVariables.rerollCost
		GlobalVariables.rerollCost+=2
		refresh_button.text = "Refresh: " + str(GlobalVariables.rerollCost) + " gold"
		GlobalVariables.resetValues(true)
		#GlobalVariables.created_spells-=1
		for shop in get_child(0).get_children():
			for card in shop.get_children():
				card.initializeCard()
