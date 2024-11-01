extends Node2D

@onready var path_follow_2d: PathFollow2D = $Path2D/PathFollow2D
@export var speed = 500
@onready var timer: Timer = $Path2D/Timer
@onready var hero: PackedScene = preload("res://hero.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if GlobalVariables.heroes_move && GlobalVariables.combat_phase:
		path_follow_2d.progress += speed * delta
		GlobalVariables.hero_progress = path_follow_2d.progress
	if GlobalVariables.heroKilled:
		var new_hero = hero.instantiate()
		get_child(0).get_child(0).add_child(new_hero)
		
		path_follow_2d.progress=0
		GlobalVariables.heroKilled = false
