extends Control

var Dungeon_Scene = preload("res://Scenes/Dungeon/Dungeon.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	$AudioStreamPlayer2D.play(0)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	$Sprite2D.visibility_layer=0
	$Demon.visibility_layer = 0
	$Button.visibility_layer = 0
	$Lore.visibility_layer = 1
	$Timer.start(4)

func _on_timer_timeout():
	Transition.change_scene("res://Scenes/Town/Town.tscn")
