extends RigidBody2D

@onready var animated_sprited = $AnimatedSprite2D
@onready var cannonball_spawn_point = $CannonBallSpawnPoint
@onready var raycast = $RayCast2D
@onready var fire_sound = $FireSound


var cannonball_scene = load("res://scenes/props/cannonball.tscn")

@export var FIRE_POWER = 1500.0
@export var FIRE_DELAY_MAX = 5.0
var fire_delay = FIRE_DELAY_MAX

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if fire_delay > 0.0:
		fire_delay -= delta
		return
	animated_sprited.play("shoot")
	
func _fire():
	var cb = cannonball_scene.instantiate()
	get_tree().root.add_child(cb)
	cb.position = cannonball_spawn_point.global_position
	cb.apply_impulse(Vector2.from_angle(self.rotation + raycast.rotation + PI / 2) * FIRE_POWER)
	self.apply_impulse(Vector2.from_angle(self.rotation + raycast.rotation + PI / 2) * 200 * -1)
	animated_sprited.play("idle")
	fire_delay = FIRE_DELAY_MAX
	fire_sound.play()

func _on_animated_sprite_2d_animation_finished():
	_fire()


func _on_visible_on_screen_enabler_2d_screen_exited():
	queue_free()
