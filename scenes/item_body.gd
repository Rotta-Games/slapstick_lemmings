extends RigidBody2D

@onready var sprite = $Sprite2D

var draggable = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if draggable and Global.is_dragging:
		var mouse_pos = get_viewport().get_mouse_position()
		var pos = get_global_position()
		var new_pos = pos + (mouse_pos - pos) * delta * 10
		set_global_position(new_pos)


func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
			self.draggable = false


func set_sprite_texture(texture: CompressedTexture2D):
	self.sprite.texture = texture
