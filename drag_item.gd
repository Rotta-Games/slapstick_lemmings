extends TextureRect

@export var item_scene: PackedScene


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			Global.is_dragging = true
			var container = get_node("%DragContainer")
			var item = item_scene.instantiate()
			container.add_child(item)

