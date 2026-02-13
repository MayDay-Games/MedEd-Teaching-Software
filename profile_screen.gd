extends Control

@onready var password_pop = $PasswordPop
@onready var new_profile_pop = $NewProfilePop
@onready var list = $NinePatchRect/MarginContainer/VBoxContainer/HBoxContainer/ScrollContainer/ProfileList

var profile_name = ""

signal new_profile

func _ready() -> void:
	ProfileController.connect("profile_changed", change_profile)

func change_profile():
	print("changing profile")
	profile_name = ProfileController.active_profile
	list.add_item(profile_name)

func _on_new_profile_pressed() -> void:
	new_profile_pop.show()


func _on_new_p_cancel_pressed() -> void:
	new_profile_pop.hide()


func _on_new_p_enter_pressed() -> void:
	emit_signal("new_profile")
	


func _on_open_editor_pressed() -> void:
	get_tree().change_scene_to_file("res://Editor/editor_main_c.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()
