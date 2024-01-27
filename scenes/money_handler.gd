extends Node

@onready var money_text: Label = get_tree().get_root().get_node("Node2D/DragUI/Money") 

@export var initial_player_money = 40
var money = initial_player_money

func _ready():
	pass # Replace with function body.

func substract(amount):
	money = money - amount

func reset():
	money = initial_player_money

func _process(delta):
	money_text.text = "$" + str(money)
