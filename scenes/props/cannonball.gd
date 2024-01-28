extends RigidBody2D

var instantiation_timestamp: float = 0.0
var already_hit_the_player = false

# Called when the node enters the scene tree for the first time.
func _ready():
	self.instantiation_timestamp = Time.get_ticks_msec() / 1000.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
