extends Node2D

@onready var left_leg = $BodyParts/LeftLeg
@onready var right_leg = $BodyParts/RightLeg
@onready var body = $BodyParts/Body
@onready var body_parts = $BodyParts
@onready var head = $BodyParts/Head

var move_right : bool = false
var move_left : bool = false

enum Direction{LEFT = -1, RIGHT = 1}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
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
	if move_right:
		_move_right(delta)
	elif move_left:
		_move_left(delta)
	else:
		_idle(delta)

func _move_right(delta):
	_flip(false)
	body_parts.scale.x = 1
	_move(delta, Direction.RIGHT)

func _move_left(delta):
	_flip(true)
	_move(delta, Direction.LEFT)
	

func _move(delta, dir : Direction):
	body.apply_impulse(Vector2(-10 * dir, -10))
	left_leg.apply_impulse(Vector2(10 * dir, -5))
	right_leg.apply_impulse(Vector2(10 * dir, -5))
	head.apply_impulse(Vector2(-10 * dir, -10))
	
	right_leg.angular_velocity = 15 * dir
	left_leg.angular_velocity = 15 * dir
	#left_leg.rotation = 0.4 * sin(left_leg.rotation + delta) * dir
	#right_leg.rotation = 0.5 * sin(right_leg.rotation + delta) * dir
	print("leg rotation: " + str(left_leg.rotation_degrees))

func _idle(delta):
	right_leg.angular_velocity = 0
	left_leg.angular_velocity = 0

func _flip(value):
	for body_part in body_parts.get_children():
		body_part.scale.x = -1 if value else 1


