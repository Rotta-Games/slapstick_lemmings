extends RigidBody2D

@onready var sprite = $AnimatedSprite2D
@onready var shape = $CollisionShape2D

var timer

func _on_timer_timeout():
	var tween = get_tree().create_tween()
	tween.tween_property(shape.shape, "radius", 100, 0.1)
	tween.tween_callback(self.queue_free)


func _input(event):
	if event is InputEventMouseButton and not event.pressed:
		sprite.play("boom")
		timer = get_tree().create_timer(3.0)
		timer.connect("timeout", self._on_timer_timeout)
