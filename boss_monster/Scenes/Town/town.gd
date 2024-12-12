extends Node2D
var Dungeon_Scene = preload("res://Scenes/Dungeon/Dungeon.tscn")
@onready var h_box_container: HBoxContainer = $HBoxContainer
@onready var hero_2: Node2D = $HBoxContainer/Hero2
@onready var hero_3: Node2D = $HBoxContainer/Hero3
@onready var hero_1: Node2D = $HBoxContainer/Hero1
@onready var hero_4: Node2D = $HBoxContainer/Hero4
@onready var hero_5: Node2D = $HBoxContainer/Hero5
@onready var hero_6: Node2D = $HBoxContainer/Hero6
@onready var hero_7: Node2D = $HBoxContainer/Hero7
@onready var label: Label = $Label
@onready var timer: Timer = $Timer

var i = 0
  
# Called when the node enters the scene tree for the first time.
func _ready():
	$AudioStreamPlayer2D.play(0)
	for hero in h_box_container.get_children():
		hero.idle_animation.visible = true
		hero_1.idle_animation.animation = "barbarian"
		hero_2.idle_animation.animation = "monk"
		hero_3.idle_animation.animation = "cleric"
		hero_4.idle_animation.animation = "lucky_fellow"
		hero_5.idle_animation.animation = "paladin"
		hero_6.idle_animation.animation = "ranger"
		hero_7.idle_animation.animation = "mage"
		
		if hero.idle_animation.animation == "barbarian":
			hero.position.y += 50
		if hero.idle_animation.animation == "monk":
			hero.idle_animation.flip_h = not hero.idle_animation.flip_h
		hero.health_bar.visible = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	i += delta
	
	for hero in h_box_container.get_children():
		if i >= 1:
			hero.idle_animation.flip_h = not hero.idle_animation.flip_h
		i = 0
		
	if GlobalVariables.infamy == 10:
		label.text = "The town is threatened by your dungeon and has issued a quest to destroy you"
	elif GlobalVariables.infamy == 20:
		label.text = "Local mayor has realized that they need help in exterminating you and has sought help from a nearby city"
	elif GlobalVariables.infamy == 20:
		label.text = "The ruler of the kingdom has issued a quest to destroy you "
	elif GlobalVariables.infamy == 20:
		label.text = "The king has sought help from nearby kingdoms"
	elif GlobalVariables.infamy == 20:
		label.text = "Emperor of the realm gathering an army to vanquish you"

func _on_button_pressed() -> void:
	Transition.change_scene("res://Scenes/Dungeon/Dungeon.tscn")


func _on_timer_timeout() -> void:
	label.text = "Some of these heroes will be attacking your dungeon. Click them for more information!"

func _on_barbarian_pressed() -> void:
	label.text = "Fueled by primal fury, they are unstoppable forces of nature, cleaving through enemies with raw strength and unyielding resolve."

func _on_monk_pressed() -> void:
	label.text = "Disciplined and resilient, they are masters of body and mind, striking with the precision of a calm breeze before a storm."
	
func _on_cleric_pressed() -> void:
	label.text = "Guided by faith and armed with divine power, they shield the innocent and banish the dark, a bridge between realms."

func _on_lucky_fellow_pressed() -> void:
	label.text = "Neither fate nor fortune can escape them; their uncanny luck is a gift as powerful as any spell or blade."
	
func _on_paladin_pressed() -> void:
	label.text = "A guardian of justice, they stand as beacons of hope, their blade shining with the purity of their unbreakable vow."

func _on_ranger_pressed() -> void:
	label.text = "With eyes sharp as a hawk’s and steps silent as shadows, they’re the watchers of the wilderness, striking with unerring aim."

func _on_mage_pressed() -> void:
	label.text = "With arcane knowledge and an iron focus, they wield forces beyond the ordinary, conjuring magic to bend reality to their will."
