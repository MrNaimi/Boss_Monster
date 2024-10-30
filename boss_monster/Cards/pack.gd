extends MarginContainer

@onready var Database = preload("res://Database/Database.gd")
@onready var DatabaseTemp = Database.new()
var Cardname = 'Gas_Leak'
@onready var CardInfo = Database.DATA[DatabaseTemp.get(Cardname)]
@onready var CardImg = (CardInfo[5])
@onready var CardHealth = (CardInfo[1])
@onready var CardName = (CardInfo[2])
@onready var CardDescription = (CardInfo[4])

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(CardInfo)
	print(CardImg)
	print(CardHealth)
	print(CardName)
	print(CardDescription)
	
	var CardSize = size
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
