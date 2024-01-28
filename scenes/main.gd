extends Node2D

@onready var quit_sound = $QuitSound
@onready var start_sound = $StartSound


func _ready():
	$Control/QuitButton.pressed.connect(self._on_quit)
	$Control/StartButton.pressed.connect(self._start_game)
	$Control/CreditsButton.pressed.connect(self._credits)


func _on_quit():
	quit_sound.play()

func _start_game():
	start_sound.play()


func _on_quit_sound_finished():
	get_tree().quit()


func _on_start_sound_finished():
	get_tree().change_scene_to_file("res://scenes/level1.tscn")


func _credits():
	$TitleText.visible = not $TitleText.visible
	$CreditsText.visible = not $CreditsText.visible
