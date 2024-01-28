extends Node2D

@onready var time_label = $TimeLabel
@onready var timer: Timer = get_tree().get_root().get_node("Node2D/EndTimer") 

func _process(_delta):
	var format_str = "Time remaining\n%ss"
	var time = timer.wait_time if timer.paused else timer.time_left

	time_label.text = format_str % str(int(time))
	
