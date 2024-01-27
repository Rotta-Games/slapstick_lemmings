extends Node2D

@onready var left_leg = $BodyParts/LeftLeg
@onready var right_leg = $BodyParts/RightLeg
@onready var left_arm = $BodyParts/LeftArm
@onready var right_arm = $BodyParts/RightArm
@onready var body = $BodyParts/Body
@onready var body_parts = $BodyParts
@onready var head = $BodyParts/Head
@onready var hat = $Hat
@onready var head_sprite = $BodyParts/Head/AnimatedSprite2D

const face_anims = ["anim_1", "anim_2", "anim_3", "anim_4", "anim_5"]

var move_right : bool = false
var move_left : bool = false

enum Direction{LEFT = -1, RIGHT = 1}

const SLIP_FORCE = Vector2(120, -200)
const SLIP_TORQUE = -5000.0

var no_physics_timer = 0.0
const NO_PHYSICS_DELAY = 1.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func _play_random_face_anim():
	var rand_index = randi() % face_anims.size()
	head_sprite.play(face_anims[rand_index])
	
func slide_n_slip():
	# please dont kill me
	_play_random_face_anim()
	var body_velocity = body.linear_velocity
	var dir = Direction.LEFT if body_velocity.x < 0 else Direction.RIGHT
	left_leg.apply_impulse(Vector2(SLIP_FORCE.x * dir, SLIP_FORCE.y / 2))
	right_leg.apply_impulse(Vector2(SLIP_FORCE.x * dir, SLIP_FORCE.y / 2))
	body.apply_impulse(Vector2(SLIP_FORCE.x * dir, SLIP_FORCE.y))
	head.apply_impulse(Vector2(SLIP_FORCE.x * dir * -1, SLIP_FORCE.y * -0.5))
	var apply_torq = func(part):
		part.apply_torque_impulse(SLIP_TORQUE * dir)
	_for_each_body_part(apply_torq)
	_disable_physics(NO_PHYSICS_DELAY)

func _disable_physics(time):
	no_physics_timer = NO_PHYSICS_DELAY

func _for_each_body_part(cb):
	for body_part in body_parts.get_children():
		cb.call(body_part)

func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_D:
			move_right = true
			move_left = false
		elif event.pressed and event.keycode == KEY_A:
			move_left = true
			move_right = false
		else:
			move_left = false
			move_right = false
			

func _physics_process(delta):
	if no_physics_timer > 0.0:
		no_physics_timer -= delta
		return
	if move_right:
		_move_right(delta)
	elif move_left:
		_move_left(delta)
	else:
		_idle(delta)

func _move_right(delta):
	_flip(false)
	_move(delta, Direction.RIGHT)

func _move_left(delta):
	_flip(true)
	_move(delta, Direction.LEFT)
	

func _move(delta, dir : Direction):
	body.apply_impulse(Vector2(-8 * dir, -8))
	left_leg.apply_impulse(Vector2(8 * dir, -5))
	right_leg.apply_impulse(Vector2(8 * dir, -5))
	head.apply_impulse(Vector2(-8 * dir, -15))
	
	right_leg.angular_velocity = 15 * dir
	left_leg.angular_velocity = 15 * dir



func _idle(delta):
	right_leg.angular_velocity = 0
	left_leg.angular_velocity = 0
	head.apply_impulse(Vector2(0, -50))
	left_leg.apply_impulse(Vector2(0, 10))
	right_leg.apply_impulse(Vector2(0, 10))

func _flip(value):
	for body_part in body_parts.get_children():
		body_part.scale.x = -1 if value else 1


func _on_animated_sprite_2d_animation_finished():
	head_sprite.play("idle")
