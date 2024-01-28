extends RigidBody2D


func _on_timer_timeout():
	var tween = get_tree().create_tween()
	tween.tween_property($CollisionShape2D.shape, "radius", 100, 0.1)
	tween.tween_callback(self.queue_free)


func _input(event):
	if event is InputEventMouseButton and not event.pressed:
		$AnimatedSprite2D.play("boom")
		$Timer.start()
