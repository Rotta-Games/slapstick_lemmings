extends RigidBody2D

@onready var sprite = $AnimatedSprite2D
@onready var shape = $CollisionShape2D
@onready var sound = $FireSound

var timer

func _on_timer_timeout():
	var tween = get_tree().create_tween()
	sound.play()
	tween.tween_property(shape.shape, "radius", 100, 0.1)
	var kill_timer = get_tree().create_timer(0.5)
	kill_timer.connect("timeout", self._on_fire_sound_finished)


func _input(event):
	if event is InputEventMouseButton and not event.pressed:
		sprite.play("boom")
		timer = get_tree().create_timer(3.0)
		timer.connect("timeout", self._on_timer_timeout)


func _on_fire_sound_finished():
	queue_free()

