extends Control

@onready var ModEditWin = $ModuleEditPop



func _on_back_pressed() -> void:
	#save changes somewhere
	get_tree().change_scene_to_file("res://MainMenu/main_menu_scene.tscn")


func _load_modules() -> void:
	pass
