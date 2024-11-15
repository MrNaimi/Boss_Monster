extends Node2D

@export var speed = 500
@onready var hero: PackedScene = preload("res://hero.tscn")
@onready var heroandpath: PackedScene = preload("res://path_follow_2d.tscn")
@onready var herolimit = 3
@onready var currentheroes = 1
@onready var timer: Timer = $Timer

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#print(get_child(0).get_children())
	for path in get_child(0).get_children():
		pass
		#print(path.progress)
	timer.wait_time = GlobalVariables.timerAmount
	if GlobalVariables.timerStart:
		timer.start()
		GlobalVariables.timerStart = false
	if GlobalVariables.heroes_move && GlobalVariables.currentPhase=="combat":
		for path in get_child(0).get_children():
			if path.get_child(0).can_move:
				path.progress=path.progress+speed*delta*path.get_child(0).path_direction
			if path.get_child(0) == null:
				path.queue_free()
			else:
				if path.progress > 850 and path.progress < 1850:
					path.get_child(0).get_child(0).flip_h = true
				else:
					path.get_child(0).get_child(0).flip_h = false
	
			
				
		#path_follow_2d.progress += speed * delta
		#GlobalVariables.hero_progress = path_follow_2d.progress
	if GlobalVariables.spawn_hero && GlobalVariables.currentPhase=="combat":
		if currentheroes < herolimit:
			var new_hero = heroandpath.instantiate()
			get_child(0).add_child(new_hero)
			#print(get_child(0).get_children())
			GlobalVariables.heroKilled = false
			GlobalVariables.spawn_hero = false
			currentheroes +=1
		if GlobalVariables.amount_of_heroes_killed == herolimit:
			GlobalVariables.currentPhase = "build"
			GlobalVariables.actionsLeft = 2
			currentheroes = 0
			herolimit += 1
			GlobalVariables.amount_of_heroes_killed=0
		


func _on_timer_timeout() -> void:
	if GlobalVariables.is_everyone_stopped():
		for path in GlobalVariables.spawned_heroes:
			if is_instance_valid(path):
				path.get_child(0).can_move=true
		GlobalVariables.heroes_move=true
