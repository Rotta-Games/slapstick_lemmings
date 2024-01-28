extends Node2D

@onready var time_label = $TimeLabel
@onready var timer: Timer = get_tree().get_root().get_node("Node2D/EndTimer") 

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var format_str = "Time remaining\n%ss"
	time_label.text = format_str % str(int(timer.time_left))
	
