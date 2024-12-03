class_name Hand
extends HBoxContainer
@onready var card: PackedScene = preload("res://Cards/card_ui.tscn")

func _ready() -> void:
	startcardmachine()


func _process(delta) -> void:
	if GlobalVariables.createCard:
		print("luodaanpas kortti tänne :)))")
		add_child(card.instantiate())
		startcardmachine()
		GlobalVariables.createCard = false
		
		
func _on_card_ui_reparent_requested(child: CardUI) -> void:
	child.reparent(self)

func startcardmachine() -> void:
	for child in get_children():
		if child is CardUI:
			var card_ui := child as CardUI
			card_ui.reparent_requested.connect(_on_card_ui_reparent_requested)
