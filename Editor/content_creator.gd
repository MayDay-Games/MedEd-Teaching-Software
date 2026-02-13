extends Control

@onready var side_box = $MarginContainer/VBoxContainer/HBoxContainer/SideMenuBox

var side_box_open = true

func _ready() -> void:
	if side_box_open == true:
		@warning_ignore("integer_division")
		side_box.custom_minimum_size.x = DisplayServer.window_get_size().x/6
	#var width = DisplayServer.window_get_size().x
	#print(width)
	#@warning_ignore("integer_division")
	#side_box.custom_minimum_size.x = width/5
	#print(side_box.custom_minimum_size.x)


func _process(delta: float) -> void:
	pass
