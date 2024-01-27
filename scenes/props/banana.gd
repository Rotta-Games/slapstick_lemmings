extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_static_body_2d_body_entered(body):
	if body.is_in_group("PlayerPart"):
		_push_player()
		_trigger_dispose()
		
func _push_player():
	var player = get_tree().get_nodes_in_group("Player")[0]
	player.slide_n_slip()

func _trigger_dispose():
	print("TODO dewa tee animaatio banaanille")
	queue_free()
