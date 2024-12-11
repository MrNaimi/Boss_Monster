extends Control
@onready var trap_dmg_buff: Label = $ScrollContainer/HBoxContainer/VBoxContainer2/TrapDmgBuff
@onready var undead_dmg_buff: Label = $ScrollContainer/HBoxContainer/VBoxContainer2/UndeadDmgBuff
@onready var demon_dmg_buff: Label = $ScrollContainer/HBoxContainer/VBoxContainer2/DemonDmgBuff
@onready var construct_dmg_buff: Label = $ScrollContainer/HBoxContainer/VBoxContainer2/ConstructDmgBuff
@onready var humanoid_dmg_buff: Label = $ScrollContainer/HBoxContainer/VBoxContainer2/HumanoidDmgBuff
@onready var spike_dmg_buff: Label = $ScrollContainer/HBoxContainer/VBoxContainer2/SpikeDmgBuff
@onready var rooms_placed: Label = $ScrollContainer/HBoxContainer/VBoxContainer2/RoomsPlaced
@onready var rooms_destroyed: Label = $ScrollContainer/HBoxContainer/VBoxContainer2/RoomsDestroyed
@onready var heroes_killed: Label = $ScrollContainer/HBoxContainer/VBoxContainer2/HeroesKilled
@onready var damage_done: Label = $ScrollContainer/HBoxContainer/VBoxContainer2/DamageDone
@onready var trap_activations: Label = $ScrollContainer/HBoxContainer/VBoxContainer2/TrapActivations

@onready var i = 0 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	i+=delta
	if i>=0.05:
		refreshStats()
		i=0

func refreshStats() -> void:
	trap_dmg_buff.text = str(GlobalVariables.TrapDmgBuff)
	undead_dmg_buff.text = str(GlobalVariables.UndeadDmgBuff)
	demon_dmg_buff.text = str(GlobalVariables.DemonDmgBuff)
	construct_dmg_buff.text = str(GlobalVariables.ConstructDmgBuff)
	humanoid_dmg_buff.text = str(GlobalVariables.HumanoidDmgBuff)
	spike_dmg_buff.text = str(GlobalVariables.SpikeTrapDmgBuff)
	rooms_placed.text = str(GlobalVariables.rooms_placed_num)
	rooms_destroyed.text = str(GlobalVariables.rooms_destroyed)
	heroes_killed.text = str(GlobalVariables.heroes_killed)
	damage_done.text = str(GlobalVariables.damage_done)
	trap_activations.text = str(GlobalVariables.TrapActivations)
