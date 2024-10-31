extends Area2D

signal hurt(damage)
#@onready var damage = get_parent().trap_dmg


func _on_area_entered(area: Area2D) -> void:
	area.damage=1
