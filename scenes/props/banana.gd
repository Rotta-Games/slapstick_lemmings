extends RigidBody2D

@onready var player: Node2D = get_tree().get_nodes_in_group("Player")[0]
@onready var collisionShape: CollisionShape2D = $PhysicsShape2D
@onready var banana_area2d: Area2D = $CollisionBody

var is_destroyed = true

func _ready():
	add_to_group("Items")

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
