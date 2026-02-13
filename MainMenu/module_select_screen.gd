extends Control


@onready var WelcomeLabel = $MarginContainer/VBoxContainer/HBoxContainer/VBoxContainer/WelcomeLabel
@onready var MainMenu = "res://MainMenu/main_menu_scene.tscn"
@onready var SettingsMenu = $MarginContainer/VBoxContainer/CenterContainer/SettingsMenu


func _ready() -> void:
	WelcomeLabel.set_text("Welcome " + ProfileController.active_profile)
	SettingsMenu.set_visible(false)


func _on_logout_button_pressed() -> void:
	get_tree().change_scene_to_file(MainMenu)


func _on_esc_button_pressed() -> void:
	SettingsMenu.set_visible(true)


func _on_settings_button_pressed() -> void:
	pass # Replace with function body.
