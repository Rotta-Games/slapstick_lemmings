extends TextureRect

@onready var ui = $DragUi
@onready var drag_container = $DragUi/DragContainer

var item_scene = preload("res://scenes/item_body.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			Global.is_dragging = true
			var item = item_scene.instantiate()
			item.sprite
