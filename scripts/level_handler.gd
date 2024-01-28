extends Node

enum LevelState {IDLE, ACTIVE}
var current_state = LevelState.IDLE
signal level_state_changed(new_state)

@onready var end_timer = $EndTimer

func _ready():
	$FilmButtons/Control/ActionButton.pressed.connect(_toggle_level_state)

func _toggle_level_state():
	if current_state == LevelState.IDLE:
		level_state_changed.emit(LevelState.ACTIVE)
		current_state = LevelState.ACTIVE
		end_timer.start()
	else:
		level_state_changed.emit(LevelState.IDLE)
		current_state = LevelState.IDLE
		end_timer.stop()
		reset_level()
		
func reset_level():
	for item in get_tree().get_nodes_in_group("Items"):
		item.queue_free()
	get_tree().call_group("Items", "queue_free")
	get_tree().reload_current_scene()
	Global.score = 0
	
func run_level():
	level_state_changed.emit(LevelState.ACTIVE)
	

func _process(delta):
	pass

func reset():
	get_tree().reload_current_scene()
	Global.score = 0
