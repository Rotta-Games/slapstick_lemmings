extends Node
@onready var player: Node2D = get_tree().get_nodes_in_group("Player")[0]
@onready var end_text: Node = get_tree().get_root().get_node("Node2D/EndText") 
@onready var end_sprite = $EndSprite
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if body.is_in_group("PlayerPart"):
		_trigger_end()

		
func _trigger_end():
	var tween_pos = get_tree().create_tween()
	var end_pos = end_sprite.global_position
	end_pos.y += 640
	tween_pos.tween_property(end_sprite, "global_position", end_pos, 0.8).set_trans(Tween.TRANS_EXPO)
	tween_pos.tween_callback(_end)

	
func _end():
	get_tree().paused = true
	end_text.show_end()
