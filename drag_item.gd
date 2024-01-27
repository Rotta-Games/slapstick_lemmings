extends TextureRect

@export var item_scene: PackedScene

var item_body: PackedScene = preload("res://scenes/item_body.tscn")


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

			var item = item_body.instantiate()
			item.prop_scene = item_scene
			get_tree().root.add_child(item)

