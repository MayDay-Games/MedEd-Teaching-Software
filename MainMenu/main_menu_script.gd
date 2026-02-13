extends Control

@onready var exit_conf_pop = $ExitConfirmationPopup
@onready var login_pop = $LoginPopup
@onready var profile_list_cont = $LoginPopup/LoginCont/Panel/MarginContainer/VBoxContainer/ScrollContainer/ProfileList
@onready var new_profile_pop = $NewProfilePop
@onready var warning_pop = $WarningPop
@onready var warning_text = $WarningPop/Panel/WarningText

@onready var warning_timer = $WarningTimer

@onready var Module_Scene = "res://Modules/content_viewer.tscn"

var selected_profile = ""


func _ready() -> void:
	exit_conf_pop.hide()
	login_pop.hide()
	new_profile_pop.hide()
	warning_pop.hide()


func _process(delta: float) -> void:
	print(login_pop.visible)

func _on_exit_pressed() -> void:
	exit_conf_pop.show()


func _on_exitcancel_pressed() -> void:
	exit_conf_pop.hide()




func _on_quit_pressed() -> void:
	get_tree().quit()



func _on_login_pressed() -> void:
	login_pop.show()


func _on_guest_pressed() -> void:
	selected_profile = "Guest"
	start()


func _on_login_cancel_pressed() -> void:
	login_pop.hide()


func _on_new_profile_pressed() -> void:
	login_pop.hide()
	new_profile_pop.show()


func _on_start_pressed() -> void:
	if profile_list_cont.is_anything_selected():
		var selected_profile_id = profile_list_cont.get_selected_items()
		selected_profile = profile_list_cont.get_item_text(selected_profile_id[0])
		start()
	else:
		await _warning("Select a profile")
		login_pop.show()


func _on_profile_list_item_activated(index: int) -> void:
	selected_profile = profile_list_cont.get_item_text(index)
	start()

	
func start():
	ProfileController.call_deferred("_set_profile", selected_profile)
	get_tree().change_scene_to_file(Module_Scene)


func _on_create_cancel_pressed() -> void:
	new_profile_pop.hide()
	login_pop.show()


func _on_profile_create_pressed() -> void:
	var new_name_node = $NewProfilePop/LoginCont/Panel/MarginContainer/VBoxContainer/VBoxContainer/ProfileNameEntry/ProfileNameEdit
	var usertype_select = $NewProfilePop/LoginCont/Panel/MarginContainer/VBoxContainer/VBoxContainer/UsertypeEntry/TypeSelect
	
	if new_name_node.get_text() != "":
		pass
	else:
		await _warning("no name entered")
		new_profile_pop.show()
		return
	
	if usertype_select.get_selected_id() != -1:
		pass
	else:
		print("no usertype selected")
		return
		
	var new_name = new_name_node.get_text()
	var avail = ProfileController.call("_check_profile_avail", new_name)
	if avail == true:
		print("name is available")
	else:
		print("name is not available")
		return
		

func _warning(text):
	warning_text.text = text
	warning_pop.show()
	await get_tree().create_timer(1).timeout
	warning_pop.hide()
	return true
