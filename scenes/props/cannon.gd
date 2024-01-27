extends RigidBody2D

@onready var cannonball_spawn_point = $CannonBallSpawnPoint
@onready var raycast = $RayCast2D

var cannonball_scene = load("res://scenes/props/cannonball.tscn")

const FIRE_POWER = 1500.0

const FIRE_DELAY_MAX = 5.0
var fire_delay = FIRE_DELAY_MAX

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if fire_delay > 0.0:
		fire_delay -= delta
		return
	_fire()
	
func _fire():
	print("TODO dewa animate cannon")
	var cb = cannonball_scene.instantiate()
	add_child(cb)
	cb.position = cannonball_spawn_point.position
	cb.apply_impulse(Vector2.from_angle(raycast.rotation + PI / 2) * FIRE_POWER)
	self.apply_impulse(Vector2.from_angle(raycast.rotation + PI / 2) * 100 * -1)
	fire_delay = FIRE_DELAY_MAX
