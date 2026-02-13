extends Control

@onready var scroll_cont = $ScrollContainer
@onready var texture_rect = $ScrollContainer/MarginContainer/TextureRect

@onready var display_image = preload("res://testing resources/Histology-Guide-001.jpg")


func _ready() -> void:
	texture_rect.set_texture(display_image)
	var h_max = scroll_cont.get_h_scroll_bar().get_max()
	scroll_cont.set_deferred("scroll_horizontal", h_max/2)
	var v_max = scroll_cont.get_v_scroll_bar().get_max()
	scroll_cont.set_deferred("scroll_vertical", v_max/2)
	
