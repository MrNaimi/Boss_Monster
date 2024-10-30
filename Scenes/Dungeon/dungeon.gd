extends Node2D

var is_dragging = false
@onready var cards: Array[Node] = []
@onready var hand: Hand = $DungeonUI/Hand
@onready var card_drop_areas: Node2D = $CardDropAreas

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	

	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Z-button"):
		print("Continue")

	
func _on_quit_game_pressed() -> void:
	get_tree().quit()


func _on_continue_button_pressed() -> void:
	print("Continue")


func _on_reset_button_pressed() -> void:
	for carddroparea in card_drop_areas.get_children():
		for room in carddroparea.get_children():
			for vboxcontainer in room.get_children():
				for card in vboxcontainer.get_children():
					if card.is_in_group("card"):
						card.reset()
