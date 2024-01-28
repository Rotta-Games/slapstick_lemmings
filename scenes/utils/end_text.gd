extends Node2D
@export var next_level: PackedScene
@onready var current_scene: Node2D = get_tree().get_root().get_node("Node2D") 

@onready var win = $Control/Winrar
@onready var lose = $Control/Lose

# Called when the node enters the scene tree for the first time.
func _ready():
	hide()
	$Control/RerunButton.pressed.connect(self.reset_level)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func show_end(victory):
	win.visible = victory
	lose.visible = not victory
	show()

func reset_level():
	hide()
	get_tree().paused = false
	for item in get_tree().get_nodes_in_group("Items"):
		item.queue_free()
	get_tree().call_group("Items", "queue_free")
	get_tree().reload_current_scene()


