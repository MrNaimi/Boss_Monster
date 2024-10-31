extends Node2D

@onready var path_follow_2d: PathFollow2D = $Path2D/PathFollow2D
@export var speed = 300
@onready var timer: Timer = $Path2D/Timer
@onready var hero: PackedScene = preload("res://hero.tscn")


@export var hp = 10
@export var dmg = 5

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#idle_animation.flip_h = true
	if GlobalVariables.heroes_move && GlobalVariables.combat_phase:
		path_follow_2d.progress += speed * delta
		GlobalVariables.hero_progress = path_follow_2d.progress
		#print()
	if GlobalVariables.heroKilled:
		path_follow_2d.progress=0
		get_child(0).get_child(0).add_child(hero.instantiate())
		
		GlobalVariables.heroKilled = false
		
