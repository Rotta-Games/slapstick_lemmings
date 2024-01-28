extends RigidBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
	$AnimatedSprite2D.play("boom")



func _on_animated_sprite_2d_animation_finished():
	var tween = get_tree().create_tween()
	tween.tween_property($CollisionShape2D.shape, "radius", 100, 0.1)
	tween.tween_callback(self.queue_free)

