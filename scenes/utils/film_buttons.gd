extends Node2D
@onready var current_scene: Node2D = get_tree().get_root().get_node("Node2D") 

enum ButtonState {ACTION, CUT}
var current_state = ButtonState.ACTION

var actionButtonImg = load("res://assets/gfx/play_button.png") 
var cutActionButtonImg = load("res://assets/gfx/cut_button.png") 


func _ready():
	current_state = ButtonState.ACTION
	current_scene.level_state_changed.connect(_on_level_state_changes)

func _on_level_state_changes(new_state):
	if new_state == current_scene.LevelState.IDLE:
		$Control/ActionButton.set_texture_normal(actionButtonImg)
	else:
		$Control/ActionButton.set_texture_normal(cutActionButtonImg)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

