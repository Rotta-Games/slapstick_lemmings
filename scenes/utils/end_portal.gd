extends Node
@onready var player: Node2D = get_tree().get_nodes_in_group("Player")[0]
@onready var end_text: Node = get_tree().get_root().get_node("Node2D/EndText") 

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if body.is_in_group("PlayerPart"):
		get_tree().paused = true
		end_text.show_end()
		
