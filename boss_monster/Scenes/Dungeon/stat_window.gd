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
@onready var hide_stat_window: Button = $"../PauseMenu/MarginContainer/VBoxContainer/HideStatWindow"
@onready var beast_dmg_buff: Label = $ScrollContainer/HBoxContainer/VBoxContainer2/BeastDmgBuff
@onready var spells_used: Label = $ScrollContainer/HBoxContainer/VBoxContainer2/SpellsUsed

@onready var i = 0
@onready var scroll_container: ScrollContainer = $ScrollContainer
@onready var color_rect: ColorRect = $ColorRect
@onready var color_rect_2: ColorRect = $ColorRect2



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
	if GlobalVariables.gatorDmgBuff > 0:
		beast_dmg_buff.text = str(GlobalVariables.BeastDmgBuff+4)
	else:
		beast_dmg_buff.text = str(GlobalVariables.BeastDmgBuff)
	rooms_placed.text = str(GlobalVariables.rooms_placed_num)
	rooms_destroyed.text = str(GlobalVariables.rooms_destroyed)
	heroes_killed.text = str(GlobalVariables.heroes_killed)
	damage_done.text = str(GlobalVariables.damage_done)
	trap_activations.text = str(GlobalVariables.TrapActivations)
	spells_used.text = str(GlobalVariables.spell_cards_used)

func _on_hide_stat_window_pressed() -> void:
	scroll_container.visible = not scroll_container.visible
	color_rect.visible = not color_rect.visible
	color_rect_2.visible = not color_rect_2.visible
	
	if hide_stat_window.text == "Show stat window":
		hide_stat_window.text = "Hide stat window"
	else:
		hide_stat_window.text = "Show stat window"
