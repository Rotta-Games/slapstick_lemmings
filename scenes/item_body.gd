extends RigidBody2D

@onready var sprite = $Spriit

var texture: CompressedTexture2D

var draggable = true

var last_mouse_pos = Vector2()
var last_diff = float()

# Called when the node enters the scene tree for the first time.
func _ready():
	self.sprite.texture = self.texture
	var mouse_pos = get_viewport().get_mouse_position()
	set_global_position(mouse_pos)
	self.gravity_scale = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if draggable and Global.is_dragging:
		var mouse_pos = get_viewport().get_mouse_position()
		var pos = get_global_position()

		var dir = pos.direction_to(mouse_pos)
		var diff = pos.distance_to(mouse_pos)

		set_global_position(mouse_pos)

		last_mouse_pos = mouse_pos
		last_diff = diff


func _input(event):
	if not draggable:
		return
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
			self.draggable = false
			self.gravity_scale = 1
			var mouse_pos = get_viewport().get_mouse_position()

			var diff = mouse_pos - last_mouse_pos
			print(diff)
			apply_central_force(diff * 1000)


func set_sprite_texture(texture: CompressedTexture2D):
	self.texture = texture
