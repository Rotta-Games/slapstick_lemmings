extends Node2D


func _ready():
	$Control/QuitButton.pressed.connect(self._on_quit)
	$Control/StartButton.pressed.connect(self._start_game)


func _on_quit():
	get_tree().quit()

func _start_game():
	get_tree().change_scene_to_file("res://scenes/level1.tscn")
