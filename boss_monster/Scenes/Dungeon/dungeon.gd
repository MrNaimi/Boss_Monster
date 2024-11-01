extends Node2D

var is_dragging = false
@onready var cards: Array[Node] = []
@onready var hand: Hand = $DungeonUI/Hand
@onready var card_drop_areas: Node2D = $CardDropAreas
@onready var path_follow_2d: PathFollow2D = $Heroes/Path2D/PathFollow2D
@onready var autoplay: Button = $VBoxContainer/Autoplay
@onready var heroes: Node2D = $Heroes
@onready var hero: PackedScene = preload("res://hero.tscn")
@onready var boss_health_bar: ProgressBar = $bossHealthBar
@onready var damage = 999
@onready var hp = 50
@onready var boss_hp: Label = $BossHp

# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	pass
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Z-button"):
		GlobalVariables.heroes_move = true
		print("Continue")
	
	
func _on_quit_game_pressed() -> void:
	get_tree().quit()


func _on_continue_button_pressed() -> void:
	print("Continue")
	GlobalVariables.heroes_move = true


func _on_reset_button_pressed() -> void:
	path_follow_2d.progress=0
	GlobalVariables.heroes_move=false
	GlobalVariables.autoplay=false
	autoplay.text="Autoplay Off"
	#hero.hp = 0
	for carddroparea in card_drop_areas.get_children():
		for room in carddroparea.get_children():
			for vboxcontainer in room.get_children():
				for card in vboxcontainer.get_children():
					if card.is_in_group("card"):
						card.reset()


func _on_autoplay_pressed() -> void:
	GlobalVariables.autoplay = !GlobalVariables.autoplay
	if GlobalVariables.autoplay:
		GlobalVariables.heroes_move=true
		autoplay.text="Autoplay On"
	else:
		autoplay.text="Autoplay Off"


func _on_area_2d_area_entered(area: Area2D) -> void:
	print(area.get_parent().get_parent().hp)
	hp -= area.get_parent().get_parent().hp
	area.get_parent().get_parent().hp=0
	boss_health_bar.value = hp
	boss_hp.text=str(hp)
	if GlobalVariables.autoplay:
		GlobalVariables.heroes_move=true
	#GlobalVariables.heroHp = RandomNumberGenerator.new().randi_range(10,15)
