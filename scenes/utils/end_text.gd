extends Node2D
@export var next_level: PackedScene
@onready var current_scene: Node2D = get_tree().get_root().get_node("Node2D") 

# Called when the node enters the scene tree for the first time.
func _ready():
	hide()
	$Control/RerunButton.pressed.connect(self.reset_level)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func show_end():
	show()

func reset_level():
	print("lol")
	hide()
	get_tree().paused = false
	current_scene.reset()
