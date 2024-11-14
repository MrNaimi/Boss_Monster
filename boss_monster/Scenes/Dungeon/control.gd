extends Control
@onready var card: PackedScene = preload("res://Cards/card_ui.tscn")
var shoplimit = 3
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#createCards()
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func createCards() -> void:
	for child in get_children():
		for index in range(shoplimit):
			add_child(card.instantiate())
	
