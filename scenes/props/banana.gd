extends RigidBody2D

@onready var player: Node2D = get_tree().get_nodes_in_group("Player")[0]
@onready var collisionShape: CollisionShape2D = $CollisionBody/CollisionShape2D

var draggable = true

var last_mouse_pos = Vector2()
var last_diff = float()
var is_destroyed = false

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
	if is_destroyed:
		pass
	if body.is_in_group("PlayerPart"):
		is_destroyed = true
		collisionShape.set_deferred("disabled", true)
		_push_player()
		_trigger_dispose()
		
func _push_player():
	player.slide_n_slip()

func _trigger_dispose():
	self.scale.y = 0.5
	if player.global_position.x < self.global_position.x:
		print("jou")
		self.apply_central_impulse(Vector2(1000,1000))
	else:
		self.apply_central_impulse(Vector2(1000,1000))
	#queue_free()
