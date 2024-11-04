extends Node2D

@export var speed = 500
@onready var hero: PackedScene = preload("res://hero.tscn")
@onready var heroandpath: PackedScene = preload("res://path_follow_2d.tscn")
@onready var herolimit = 100
@onready var currentheroes = 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#print(get_child(0).get_children())
	for path in get_child(0).get_children():
		pass
		#print(path.progress)
	if GlobalVariables.heroes_move && GlobalVariables.combat_phase:
		for path in get_child(0).get_children():
			path.progress=path.progress+speed*delta
			if path.get_child(0) == null:
				path.queue_free()
			else:
				if !GlobalVariables.heroKilled:
					if path.progress > 850 and path.progress < 1850:
						path.get_child(0).get_child(0).flip_h = true
					else:
						path.get_child(0).get_child(0).flip_h = false


			
				
		#path_follow_2d.progress += speed * delta
		#GlobalVariables.hero_progress = path_follow_2d.progress
	if GlobalVariables.heroKilled or GlobalVariables.spawn_hero:
		if currentheroes < herolimit:
			var new_hero = heroandpath.instantiate()
			get_child(0).add_child(new_hero)
			#print(get_child(0).get_children())
			GlobalVariables.heroKilled = false
			GlobalVariables.spawn_hero = false
			currentheroes +=1
