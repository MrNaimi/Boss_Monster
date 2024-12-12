class_name ShopHand
extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for ui in get_children():
		for child in ui.get_children():
			var card_ui := child as CardUI
			card_ui.reparent_requested.connect(_on_card_ui_reparent_requested)
		
			
func _on_card_ui_reparent_requested(child: CardUI) -> void:
	if get_child(0).get_child_count()<2:
		child.reparent(get_child(0))
	else:
		child.reparent(get_child(1))
