extends Node

enum user_types {
	Guest,
	MedicalStudent,
	FY,
	STAbove
}

var active_profile = "Guest"
var profile_config = ConfigFile.new()
var profile_folder_dir = "user://profiles"
var profile_list = ["Guest"]

var user_data = {
	"user_type" : 0
	
}

func _ready() -> void:
	_load_profile_folder()
	

func _set_profile(profile_name):
	active_profile = profile_name
	print("set profile to "+active_profile)
	_load_profile()
	
func _new_profile(profile_name):
	print("creating new profile " +active_profile)
	if profile_list.has(profile_name):
		profile_name = profile_name + "_"
	active_profile = profile_name
	profile_config.set_value("user_data", "user_type", 0)
	
	profile_config.save(profile_folder_dir + profile_folder_dir + active_profile + ".cfg")
	_load_profile()
		
func _load_profile():
	if profile_list.has(active_profile):
		var err = profile_config.load(profile_folder_dir + active_profile + ".cfg")
		if err != OK:
			print("loading error")
	else:
		print("profile doesn't exist")
		
	

func _load_profile_folder() -> void:
	var dir = DirAccess.open(profile_folder_dir)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if dir.current_is_dir():
				print("Found directory: " + file_name)
			else:
				print("Found file: " + file_name)
				profile_list.append(file_name)
			file_name = dir.get_next()
	else:
		var user_dir = DirAccess.open("user://")
		var new_dir = user_dir.make_dir("profiles")
		if new_dir != OK:
			print("An error occurred when trying to access the path.")
		_load_profile_folder()


func _check_profile_avail(new_name):
	if profile_list.has(new_name):
		return false
	else:
		return true
