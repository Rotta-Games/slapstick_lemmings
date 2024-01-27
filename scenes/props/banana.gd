extends RigidBody2D


var draggable = true

var last_mouse_pos = Vector2()
var last_diff = float()


func _ready():
	var mouse_pos = get_viewport().get_mouse_position()
	set_global_position(mouse_pos)
	self.gravity_scale = 0


func _process(delta):
	if draggable and Global.is_dragging:
		var mouse_pos = get_viewport().get_mouse_position()

		var pos = get_global_position()
		last_mouse_pos = mouse_pos

		var diff = pos.distance_to(mouse_pos)
		last_diff = diff

		set_global_position(mouse_pos)



func _input(event):
	if not draggable:
		return
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
			self.draggable = false
			self.gravity_scale = 1
			var mouse_pos = get_viewport().get_mouse_position()

			var diff = mouse_pos - last_mouse_pos
			apply_central_force(diff * 1000)


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
