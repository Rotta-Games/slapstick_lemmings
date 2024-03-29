extends Node2D



@onready var left_leg = $BodyParts/LeftLeg
@onready var right_leg = $BodyParts/RightLeg
@onready var body = $BodyParts/Body
@onready var body_parts = $BodyParts
@onready var head = $BodyParts/Head
@onready var head_sprite = $BodyParts/Head/AnimatedSprite2D
@onready var floor_raycast = $FloorRayCast2D
@onready var wall_raycast = $WallRayCast2D
@onready var pie_hit_sound = $PieHitSound
@onready var cannonball_hit_sound = $CannonballHitSound
@onready var banana_slip_sound = $BananaSlipSound

var last_pos
var last_rotation
var hit_score = 0
var is_active = false

const face_anims = ["anim_1", "anim_2", "anim_3", "anim_4", "anim_5"]

enum Direction{LEFT = -1, RIGHT = 1, NOPE = 0}
var move_dir: Direction = Direction.RIGHT


const SLIP_FORCE = Vector2(120, -200)
const PIE_FORCE = Vector2(-120, 100)
const SLIP_TORQUE = -5000.0

var no_physics_timer = 0.0
const NO_PHYSICS_DELAY = 1.0

# Called when the node enters the scene tree for the first time.
func _ready():
	last_pos = body.global_position
	last_rotation = body.rotation
	
func _play_random_face_anim():
	var rand_index = randi() % face_anims.size()
	head_sprite.play(face_anims[rand_index])
	
func slide_n_slip():
	banana_slip_sound.play()
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
	hit_score += 50
	
func _pie_hit():
	# please kill me
	pie_hit_sound.play()
	_play_random_face_anim()
	var body_velocity = body.linear_velocity
	var dir = Direction.LEFT if body_velocity.x < 0 else Direction.RIGHT
	body.apply_impulse(Vector2(PIE_FORCE.x * dir, PIE_FORCE.y))
	head.apply_impulse(Vector2(PIE_FORCE.x * dir * -1, PIE_FORCE.y))
	_disable_physics(NO_PHYSICS_DELAY / 2)
	hit_score += 300


func _disable_physics(_time):
	no_physics_timer = NO_PHYSICS_DELAY

func _for_each_body_part(cb):
	for body_part in body_parts.get_children():
		cb.call(body_part)

func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_D:
			self.move_dir = Direction.RIGHT
			_flip_transform(Direction.RIGHT)
		elif event.pressed and event.keycode == KEY_A:
			self.move_dir = Direction.LEFT
			_flip_transform(Direction.LEFT)

func _physics_process(delta):	
	if !is_active:
		_idle(delta)
		return
		
	_update_raycast_pos()
	_clamp_head_rotation()
	_update_score()
	last_pos = body.global_position
	last_rotation = body.rotation_degrees
	if no_physics_timer > 0.0:
		no_physics_timer -= delta
		return
	if not _floored():
		return
	if _walled():
		_flip_direction()
	if self.move_dir == Direction.RIGHT:
		_move_right(delta)
	elif self.move_dir == Direction.LEFT:
		_move_left(delta)
	else:
		_idle(delta)
		
func _update_score():
	var score_up = hit_score
	score_up += (max(0, abs(body.rotation_degrees - last_rotation) - 10))
	score_up += (max(0, abs(body.global_position.x - last_pos.x) - 4))
	score_up += (max(0, abs(body.global_position.y - last_pos.y) - 4))
	Global.score += score_up
	hit_score = 0

func _update_raycast_pos():
	floor_raycast.position = body.position
	wall_raycast.position = body.position
	
func _floored():
	return floor_raycast.is_colliding()
	
func _walled():
	return wall_raycast.is_colliding()

func _clamp_head_rotation():
	if head.rotation > PI / 2:
		head.angular_velocity = -5
	if head.rotation < -PI / 2:
		head.angular_velocity = 5

func _move_right(delta):
	_move(delta, Direction.RIGHT)

func _move_left(delta):
	_move(delta, Direction.LEFT)

func _move(_delta, dir : Direction):
	body.apply_impulse(Vector2(-8 * dir, -8))
	left_leg.apply_impulse(Vector2(8 * dir, -5))
	right_leg.apply_impulse(Vector2(8 * dir, -5))
	head.apply_impulse(Vector2(-8 * dir, -15))
	
	right_leg.angular_velocity = 15 * dir
	left_leg.angular_velocity = 15 * dir


func _idle(_delta):
	right_leg.angular_velocity = 0
	left_leg.angular_velocity = 0
	head.apply_impulse(Vector2(0, -40))
	left_leg.apply_impulse(Vector2(0, 10))
	right_leg.apply_impulse(Vector2(0, 10))

func _flip_transform(dir):
	head.get_node("Sprite2D").scale.x = dir
	body.get_node("Sprite2D").scale.x = dir
	left_leg.get_node("Sprite2D").scale.x = dir
	right_leg.get_node("Sprite2D").scale.x = dir


func _flip_direction():
	self.move_dir = (self.move_dir * -1) as Direction
	_flip_transform(self.move_dir)
	wall_raycast.scale.x *= -1


func _on_animated_sprite_2d_animation_finished():
	head_sprite.play("idle")

func get_position_for_real():
	return body.global_position


func _mihin_meni_pedro_tuu_takas():
	pass

func _on_prop_detector_area_2d_body_entered(body):
	if body.is_in_group("Pie"):
		_pie_hit()
	if body.is_in_group("CannonBall"):
		_cannonball_hit(body)
		
func _cannonball_hit(body):
	if body.instantiation_timestamp + 1 > (Time.get_ticks_msec() / 1000.0) and not body.already_hit_the_player:
		cannonball_hit_sound.play()
		body.already_hit_the_player = true


func _on_node_2d_level_state_changed(new_state):
	# This is enum and should be fetched from levelhandles
	# but fuck it! Don't care! Number it is now
	if new_state == 1:
		is_active = true
	else:
		is_active = false
