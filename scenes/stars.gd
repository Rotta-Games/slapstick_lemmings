extends Node2D

@onready var empty_1 = $EmptyStar1
@onready var empty_2 = $EmptyStar2
@onready var empty_3 = $EmptyStar3

@onready var full_1 = $FullStar1
@onready var full_2 = $FullStar2
@onready var full_3 = $FullStar3

@onready var timer = $Timer


@onready var star_sound = $AudioStreamPlayer2D
@onready var star_sound_final = $AudioStreamPlayer2D_final

var selected_star_1
var selected_star_2
var selected_star_3

var star_count = 0

var final_callback : Callable

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func show_stars(cb: Callable):
	star_count = _get_star_count()
	empty_1.visible = true
	empty_2.visible = true
	empty_3.visible = true
	final_callback = cb
	if star_count > 0:
		_tween_star_1()
	else:
		timer.start()
		
func _tween_star_1():
	var tween = get_tree().create_tween()
	tween.tween_property(full_1, "global_position", empty_1.global_position, 0.5).set_trans(Tween.TRANS_EXPO)
	if star_count > 1:
		tween.tween_callback(_tween_star_2)
	else:
		tween.tween_callback(_tween_end)
	
func _tween_star_2():
	star_sound.play()
	var tween = get_tree().create_tween()
	tween.tween_property(full_2, "global_position", empty_2.global_position, 0.8).set_trans(Tween.TRANS_EXPO)
	if star_count > 2:
		tween.tween_callback(_tween_star_3)
	else:
		tween.tween_callback(_tween_end)
	
func _tween_star_3():
	star_sound.play()
	var tween = get_tree().create_tween()
	tween.tween_property(full_3, "global_position", empty_3.global_position, 1.0).set_trans(Tween.TRANS_EXPO)
	tween.tween_callback(_tween_end)
	
func _tween_end():
	star_sound.play()
	timer.start()

func _get_star_count():
	if Global.score > Global.SCORE_FOR_3_STAR:
		return 3
	elif Global.score > Global.SCORE_FOR_2_STAR:
		return 2
	elif Global.score > Global.SCORE_FOR_1_STAR:
		return 1
	return 0


func _on_timer_timeout():
	final_callback.call()
