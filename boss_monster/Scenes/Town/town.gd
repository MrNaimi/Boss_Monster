extends Node2D
@onready var h_box_container: HBoxContainer = $HBoxContainer
@onready var hero_2: Node2D = $HBoxContainer/Hero2
@onready var hero_3: Node2D = $HBoxContainer/Hero3
@onready var hero_1: Node2D = $HBoxContainer/Hero1
@onready var hero_4: Node2D = $HBoxContainer/Hero4
@onready var hero_5: Node2D = $HBoxContainer/Hero5
@onready var hero_6: Node2D = $HBoxContainer/Hero6
@onready var hero_7: Node2D = $HBoxContainer/Hero7

var i = 0
  
# Called when the node enters the scene tree for the first time.
func _ready():
	for hero in h_box_container.get_children():
		hero.idle_animation.visible = true
		hero_1.idle_animation.animation = "barbarian"
		hero_2.idle_animation.animation = "monk"
		hero_3.idle_animation.animation = "cleric"
		hero_4.idle_animation.animation = "lucky_fellow"
		hero_5.idle_animation.animation = "paladin"
		hero_6.idle_animation.animation = "ranger"
		hero_7.idle_animation.animation = "mage"
		
		hero.position.x += -150
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
