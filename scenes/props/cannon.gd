extends RigidBody2D

@onready var animated_sprited = $AnimatedSprite2D
@onready var cannonball_spawn_point = $CannonBallSpawnPoint
@onready var raycast = $RayCast2D
@onready var fire_sound = $FireSound

@export var price = 100

var cannonball_scene = load("res://scenes/props/cannonball.tscn")

@export var FIRE_POWER: float = 1500.0

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("Items")

func _fire():
	var cb = cannonball_scene.instantiate()
	get_tree().root.add_child(cb)
	cb.add_to_group("Items")
	cb.position = cannonball_spawn_point.global_position
	cb.apply_impulse(Vector2.from_angle(self.rotation + raycast.rotation) * FIRE_POWER)
	self.apply_impulse(Vector2.from_angle(self.rotation + raycast.rotation) * 200 * -1)
	animated_sprited.play("idle")
	fire_sound.play()

func _on_animated_sprite_2d_animation_finished():
	_fire()

func _on_shoot_timer_timeout():
	animated_sprited.play("shoot")

