extends TextureRect

var drag_container

var item_scene = preload("res://scenes/item_body.tscn")

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
			item.set_sprite_texture(self.texture)
			container.add_child(item)

