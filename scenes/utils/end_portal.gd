extends Node
@onready var player: Node2D = get_tree().get_nodes_in_group("Player")[0]
@onready var end_text: Node = get_tree().get_root().get_node("Node2D/EndText") 
@onready var end_sprite = $EndSprite
@onready var stars = $Stars

var end_pos

var victory = false
# Called when the node enters the scene tree for the first time.
func _ready():
	end_pos = end_sprite.global_position
	end_pos.y += 640
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if body.is_in_group("PlayerPart"):
		victory = true
		_trigger_end()

		
func _trigger_end():
	var tween_pos = get_tree().create_tween()
	tween_pos.tween_property(end_sprite, "global_position", end_pos, 0.8).set_trans(Tween.TRANS_EXPO)
	if victory:
		tween_pos.tween_callback(_display_stars)
	else:
		tween_pos.tween_callback(_end)
		

func _display_stars():
	var callable_end = Callable(self, "_end")
	stars.show_stars(callable_end)

func _end():
	get_tree().paused = true
	end_text.show_end(victory)

func _on_end_timer_timeout():
	victory = false
	_trigger_end()
