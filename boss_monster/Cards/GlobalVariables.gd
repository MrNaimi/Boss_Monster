extends Node

var card_dragging = false
var hero_progress = 0
var traps: Array[String] = ["spikes.png","goblin_warrior.png","sauna.png","healing_potion.png","std.png"]
var trap_index=0
var heroes_move = false
var combat_phase = false
var autoplay = false
var spawn_hero = false
var hero_limit = 3
var current_heroes = 0
var timerAmount = 0.1
@onready var Database = preload("res://Database/Database.gd")
@onready var rooms: Array[Array] = []
var damageGiven = 0
var heroHp = 10 
var heroKilled = false
var bossHp = 50

func _ready() -> void:
	for i in range(Database.DATA.size()-1):
		if Database.DATA.get(i)[0]=="Room":
			rooms.append(Database.DATA.get(i))
		i+=1
		
