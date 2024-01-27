extends Node

var is_dragging = false
var movie_animation_sprites: SpriteFrames = SpriteFrames.new()

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
			is_dragging = false
