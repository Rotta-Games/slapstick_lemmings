extends RigidBody2D

@onready var animated_sprited = $AnimatedSprite2D
@onready var pie_spawn_point = $PieSpawnPoint
@onready var raycast = $RayCast2D
@onready var fire_sound = $FireSound

@export var price = 100

var pie_scene = load("res://scenes/props/pie.tscn")

@export var FIRE_POWER = 1500.0
@export var FIRE_DELAY_MAX = 1.0
var fire_delay = FIRE_DELAY_MAX

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if fire_delay > 0.0:
		fire_delay -= delta
		return
	_fire()
	
func _fire():
	animated_sprited.play("shoot")
	var pie = pie_scene.instantiate()
	get_tree().root.add_child(pie)
	pie.position = pie_spawn_point.global_position
	pie.angular_velocity = 2
	pie.apply_impulse(Vector2.from_angle(self.rotation + raycast.rotation) * FIRE_POWER)
	self.apply_impulse(Vector2.from_angle(self.rotation + raycast.rotation) * 50 * -1)
	fire_delay = FIRE_DELAY_MAX
	fire_sound.play()


func _on_visible_on_screen_enabler_2d_screen_exited():
	queue_free()


func _on_animated_sprite_2d_animation_finished():
	animated_sprited.play("idle")
