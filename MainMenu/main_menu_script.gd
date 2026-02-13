extends Control

@onready var exit_conf_pop = $ExitConfirmationPopup
@onready var login_pop = $LoginPopup
@onready var profile_list_cont = $LoginPopup/LoginCont/Panel/MarginContainer/VBoxContainer/ScrollContainer/ProfileList
@onready var new_profile_pop = $NewProfilePop
@onready var warning_pop = $WarningPop
@onready var warning_text = $WarningPop/Panel/WarningText


@onready var Module_Scene = "res://Saves and Profiles/profile_screen.tscn"

var selected_profile = ""
var profile_list = []


func _ready() -> void:
	ProfileController.connect("profile_list_changed", _profile_list_changed)
	exit_conf_pop.hide()
	login_pop.hide()
	new_profile_pop.hide()
	warning_pop.set_visible(false)
	_profile_list_changed()


func _profile_list_changed() -> void:
	#print("list changed")
	profile_list_cont.clear()
	var temp_list = ProfileController.profile_list.duplicate()
	for i in temp_list:
		profile_list_cont.add_item(i)


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
		login_pop.call_deferred("show")

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
		await _warning("Please enter a name for your profile")
		new_profile_pop.call_deferred("show")
		return
	
	if usertype_select.get_selected_id() != -1:
		pass
	else:
		await _warning("Please select a user type")
		new_profile_pop.call_deferred("show")
		return
		
	var new_name = new_name_node.get_text()
	var avail = ProfileController.call("_check_profile_avail", new_name)
	if avail == true:
		print("name is available")
		ProfileController.call_deferred("_new_profile", new_name)
	else:
		await _warning("This name is already in use")
		new_profile_pop.call_deferred("show")
		return
	

func _warning(text):
	warning_text.text = text
	warning_pop.show()
	await get_tree().create_timer(1).timeout
	warning_pop.hide()
	return true
