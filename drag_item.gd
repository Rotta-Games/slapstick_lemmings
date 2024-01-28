extends TextureRect

@onready var money_handler: Node = get_tree().get_root().get_node("Node2D/MoneyHandler") 

@export var item_scene: PackedScene

@export var price: int = 20

var item_body: PackedScene = preload("res://scenes/item_body.tscn")


func _gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:

			#if money_handler.money - price < 0:
			#	return

			Global.is_dragging = true

			var item = item_body.instantiate()
			item.prop_scene = item_scene
			item.prop_rotate = self.flip_h and self.flip_v
			get_tree().get_root().get_node("Node2D").get_node("%DragContainer").add_child(item)
		elif event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
			if Global.is_dragging:
				money_handler.substract(price)
				Global.is_dragging = false
