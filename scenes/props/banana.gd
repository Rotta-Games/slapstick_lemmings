extends RigidBody2D

@onready var player: Node2D = get_tree().get_nodes_in_group("Player")[0]
@onready var collisionShape: CollisionShape2D = $PhysicsShape2D
@onready var banana_area2d: Area2D = $CollisionBody
@onready var money_handler: Node = get_tree().get_root().get_node("Node2D/MoneyHandler") 

@export var price = 20

var draggable = true

var last_mouse_pos = Vector2()
var last_diff = float()
var is_destroyed = true

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
		# Check that player has moneyz
		if money_handler.money - price < 0:
			queue_free()
			return
			
		if event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
			self.draggable = false
			self.gravity_scale = 1
			var mouse_pos = get_viewport().get_mouse_position()

			var diff = mouse_pos - last_mouse_pos
			apply_central_force(diff * 1000)
			money_handler.substract(price)


func _on_static_body_2d_body_entered(body):
	if is_destroyed:
		pass
	if body.is_in_group("PlayerPart"):
		is_destroyed = true
		_push_player()
		_trigger_dispose()
		
func _push_player():
	player.slide_n_slip()

func _trigger_dispose():
	$Sprite2D.scale.y = 0.5
	banana_area2d.set_collision_layer_value(11, false)
	banana_area2d.set_collision_layer_value(12, false)
	#collisionShape.set_deferred('disabled', true)
	
	var player_position = player.get_position_for_real()
	
	if player_position.x < self.global_position.x:
		self.apply_central_impulse(Vector2(300,-200))
	else:
		self.apply_central_impulse(Vector2(-300,-200))
	#queue_free()
