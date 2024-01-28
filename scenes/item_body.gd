extends Node2D

var prop_scene: PackedScene
var prop: Node2D
var orig_gravity_scale: float
var prop_rotate: bool = false

var last_mouse_pos = Vector2()
var last_diff = float()

# Called when the node enters the scene tree for the first time.
func _ready():
	var mouse_pos = get_viewport().get_mouse_position()
	set_global_position(mouse_pos)

	self.prop = prop_scene.instantiate()
	self.prop.rotate(PI)
	self.prop.freeze = true
	self.add_child(self.prop)


func _process(delta):
	if Global.is_dragging:
		var mouse_pos = get_viewport().get_mouse_position()

		var pos = get_global_position()
		last_mouse_pos = mouse_pos

		var diff = pos.distance_to(mouse_pos)
		last_diff = diff

		set_global_position(mouse_pos)


func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
			var mouse_pos = get_viewport().get_mouse_position()

			var diff = mouse_pos - last_mouse_pos
			
			self.remove_child(self.prop)
			get_tree().root.add_child(self.prop)

			self.prop.set_global_position(mouse_pos)
			self.prop.freeze = false
			self.prop.apply_central_force(diff * 250)

			self.queue_free()


func set_sprite_texture(texture: CompressedTexture2D):
	self.texture = texture
