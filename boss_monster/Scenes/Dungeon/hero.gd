extends Node2D

@export var speed = 500
@onready var hero: PackedScene = preload("res://hero.tscn")
@onready var heroandpath: PackedScene = preload("res://path_follow_2d.tscn")
@onready var herolimit = 3
@onready var currentheroes = 1
@onready var timer: Timer = $Timer
@onready var refresh_button: Button = $"../DungeonUI/ShopUI/RefreshButton"
@onready var shop_ui: Control = $"../DungeonUI/ShopUI"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	timer.wait_time = GlobalVariables.timerAmount
	if GlobalVariables.timerStart:
		timer.start()
		GlobalVariables.timerStart = false
	if GlobalVariables.heroes_move && GlobalVariables.currentPhase=="combat":
		for path in get_child(0).get_children():
			if path.get_child(0).can_move && not path.get_child(0).mindcontrolled:
				path.progress=path.progress+speed*delta*path.get_child(0).path_direction
			if path.get_child(0) == null:
				path.queue_free()
			else:
				if path.progress > 850 and path.progress < 1850:
					path.get_child(0).get_child(0).flip_h = not path.get_child(0).flipped
				else:
					path.get_child(0).get_child(0).flip_h = path.get_child(0).flipped
	#
			
				
		#path_follow_2d.progress += speed * delta
		#GlobalVariables.hero_progress = path_follow_2d.progress
	if GlobalVariables.spawn_hero && GlobalVariables.currentPhase=="combat":
		if currentheroes < herolimit:
			var new_hero = heroandpath.instantiate()
			get_child(0).add_child(new_hero)
			GlobalVariables.heroKilled = false
			GlobalVariables.spawn_hero = false
			currentheroes +=1
		if GlobalVariables.amount_of_heroes_killed == herolimit:
			GlobalVariables.spawned_heroes=[]
			GlobalVariables.rerollCost=1
			GlobalVariables.currentPhase = "build"
			var robot_number = RandomNumberGenerator.new().randi_range(1, 5)
			print("Killer robot number, 5 kills ",robot_number)
			if GlobalVariables.killer_robot_placed && robot_number==5:
				print("killer robot terminated")
				GlobalVariables.killer_robot_terminate=true
				robot_number = 0
			if GlobalVariables.lions_dens_in_the_dungeon > 0:
				GlobalVariables.BeastDmgBuff-=GlobalVariables.beast_rooms_in_dungeon
			GlobalVariables.forgotten_library_activated = false
			shop_ui.createCards()
			GlobalVariables.infamy+=1
			if GlobalVariables.infamy % 10 == 0:
				Transition.change_scene("res://Scenes/Town/Town.tscn")
			GlobalVariables.actionsLeft = 2
			currentheroes = 0
			if GlobalVariables.infamy%3==0:
				herolimit+=1
			GlobalVariables.amount_of_heroes_killed=0
			GlobalVariables.values_changed = false
			GlobalVariables.playshopanim = true



func _on_timer_timeout() -> void:
	if GlobalVariables.is_everyone_stopped():
		for path in GlobalVariables.spawned_heroes:
			if is_instance_valid(path):
				path.get_child(0).can_move=true
		GlobalVariables.heroes_move=true
