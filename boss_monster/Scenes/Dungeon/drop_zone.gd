extends ColorRect

@onready var drop_zone: ColorRect = $"."
@onready var animation_player: AnimationPlayer = $"../AnimationPlayer"

var i=0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if GlobalVariables.card_dragging:
		self.visible=true
		animation_player.play("hover")
	else:
		self.visible=false
		animation_player.stop()
	#print(self.get_parent().get_child(0).get_child_count())
	if self.get_parent().get_child(0).get_child_count():
		self.visible=false
