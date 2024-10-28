extends Node2D

var draggable = false
var is_inside_droppable = false
var body_ref = null
var offset: Vector2
var initialPos
var heh = Vector2(60.00, -10.00)
var card_frame: Node2D

func _ready() -> void:
	initialPos = global_position  # Store the initial position correctly
	card_frame = find_child("Card_frame")
	
func _process(delta: float) -> void:
	if draggable:
		if Input.is_action_just_pressed("click"):
			offset = get_global_mouse_position() - global_position
			Dungeon.is_dragging = true
			card_frame.scale = Vector2(0.1, 0.1)
			
		if Input.is_action_pressed("click"):
			global_position = get_global_mouse_position()
		elif Input.is_action_just_released("click"):
			Dungeon.is_dragging = false  # Ensure this is set properly
			var tween = get_tree().create_tween()
			if is_inside_droppable and body_ref != null:  # Check if body_ref is valid
				tween.tween_property(self, "global_position", body_ref.global_position - heh, 0.2).set_ease(Tween.EASE_OUT)
			else:
				tween.tween_property(self, "global_position", initialPos, 0.2).set_ease(Tween.EASE_OUT)

func _on_area_2d_mouse_entered() -> void:
	print("päällä")
	if not Dungeon.is_dragging:
		var tween = get_tree().create_tween()
		draggable = true
		card_frame.scale = Vector2(0.2, 0.2)
		card_frame.position = (initialPos + Vector2(0,10))
		position = card_frame.position
		#position = global_position + Vector2(0,-100)
		
		

func _on_area_2d_mouse_exited() -> void:
	print("pois päältä")
	if not Dungeon.is_dragging:
		draggable = false
		card_frame.scale = Vector2(0.1, 0.1)
		
		#Snaps card to position when it touches dragspot, otherwise goes to initialposition
		if body_ref != null:
			position = body_ref.global_position - heh
		else:
			position = initialPos

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group('droppable'):
		is_inside_droppable = true
		body.modulate = Color(Color.GREEN)
		body_ref = body  # Store a reference to the droppable body

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group('droppable'):
		is_inside_droppable = false
		body.modulate = Color(Color.BLUE)
		body_ref = null  # Reset body_ref when the draggable object exits the droppable area
