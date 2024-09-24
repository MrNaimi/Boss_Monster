extends Node2D

var draggable = false
var is_inside_droppable = false
var body_ref
var offset: Vector2
var initialPos


func _ready() -> void:
	pass
	
func _process(delta: float) -> void:
	if draggable:
		
		if Input.is_action_just_pressed("click"):
			var initialPos = global_position
			offset = get_global_mouse_position() - global_position
			Dungeon.is_dragging = true
			scale = Vector2(2.00, 2.00)
			
		if Input.is_action_pressed("click"):
			global_position = get_global_mouse_position()
		elif Input.is_action_just_released("click"):
			Dungeon.is_dragging
			var tween = get_tree().create_tween()
			if is_inside_droppable:
				tween.tween_property(self, "position", body_ref.position,0.2).set_ease(Tween.EASE_OUT)
			else:
				tween.tween_property(self, "global_position", initialPos,0.2).set_ease(Tween.EASE_OUT)
				
func _on_area_2d_mouse_entered() -> void:
	print("päällä")
	if not Dungeon.is_dragging:
		draggable = true
		scale = Vector2(4.00, 4.00)

func _on_area_2d_mouse_exited() -> void:
	print("pois päältä")
	if not Dungeon.is_dragging:
		draggable = false
		scale = Vector2(2, 2)

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group('droppable'):
		is_inside_droppable = true
		body.modulate = Color(Color.GREEN)
		body_ref = body

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group('droppable'):
		is_inside_droppable = false
		body.modulate =  Color(Color.BLUE)
