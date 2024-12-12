extends Control

@onready var cleric = $Node2D/Hero/cleric
@onready var barbarian = $Node2D/Hero/barbarian
@onready var luckyfellow =$Node2D/Hero/luckyfellow
@onready var mage =$Node2D/Hero/mage
@onready var monk =$Node2D/Hero/monk
@onready var paladin =$Node2D/Hero/paladin
@onready var ranger =$Node2D/Hero/ranger

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_back_pressed() -> void:
	Transition.change_scene("res://Scenes/Main_menu/main_menu.tscn")
func _on_heroes_pressed() -> void:
	$Node2D/Boss.visibility_layer =0
	$Node2D/Spell.visibility_layer =0
	$Node2D/Room.visibility_layer =0
	$Node2D/Hero.visibility_layer =1
func _on_bosses_pressed() -> void:
	$Node2D/Hero.visibility_layer =0
	$Node2D/Spell.visibility_layer =0
	$Node2D/Room.visibility_layer =0
	$Node2D/Boss.visibility_layer =1

func _on_traps_pressed() -> void:
	$Node2D/Hero.visibility_layer =0
	$Node2D/Boss.visibility_layer =0
	$Node2D/Spell.visibility_layer =0
	$Node2D/Room.visibility_layer =1

func _on_spells_pressed() -> void:
	$Node2D/Hero.visibility_layer =0
	$Node2D/Boss.visibility_layer =0
	$Node2D/Room.visibility_layer =0
	$Node2D/Spell.visibility_layer =1



func _on_cleric_mouse_entered() -> void:
	cleric.play("default")
	$"Node2D/Hero/cleric/cleric text".visibility_layer = 1
func _on_barbarian_mouse_entered() -> void:
	barbarian.play("default")
	$"Node2D/Hero/barbarian/barbarian text".visibility_layer = 1
func _on_luckyfellow_mouse_entered() -> void:
	luckyfellow.play("default")
	$"Node2D/Hero/luckyfellow/luckyfellow text".visibility_layer = 1
func _on_mage_mouse_entered() -> void:
	mage.play("default")
	$"Node2D/Hero/mage/mage text".visibility_layer = 1
func _on_monk_mouse_entered() -> void:
	monk.play("default")
	$"Node2D/Hero/monk/monk text".visibility_layer = 1
func _on_paladin_mouse_entered() -> void:
	paladin.play("default")
	$"Node2D/Hero/paladin/paladin text".visibility_layer = 1
func _on_ranger_mouse_entered() -> void:
	ranger.play("default")
	$"Node2D/Hero/ranger/ranger text".visibility_layer = 1


func _on_barbarian_mouse_exited() -> void:
	barbarian.stop()
	$"Node2D/Hero/barbarian/barbarian text".visibility_layer = 0
func _on_cleric_mouse_exited() -> void:
	cleric.stop()
	$"Node2D/Hero/cleric/cleric text".visibility_layer = 0
func _on_luckyfellow_mouse_exited() -> void:
	luckyfellow.stop()
	$"Node2D/Hero/luckyfellow/luckyfellow text".visibility_layer = 0
func _on_mage_mouse_exited() -> void:
	mage.stop()
	$"Node2D/Hero/mage/mage text".visibility_layer = 0
func _on_monk_mouse_exited() -> void:
	monk.stop()
	$"Node2D/Hero/monk/monk text".visibility_layer = 0
func _on_paladin_mouse_exited() -> void:
	paladin.stop()
	$"Node2D/Hero/paladin/paladin text".visibility_layer = 0
func _on_ranger_mouse_exited() -> void:
	ranger.stop()
	$"Node2D/Hero/ranger/ranger text".visibility_layer = 0
