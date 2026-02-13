extends Control

@onready var password_pop = $PasswordPop
@onready var new_profile_pop = $NewProfilePop

signal new_profile


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
