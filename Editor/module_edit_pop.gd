extends CenterContainer


@onready var WindowTitle = $PanelContainer/MarginContainer/VBoxContainer/WindowTitle
@onready var TitleTextEdit = $PanelContainer/MarginContainer/VBoxContainer/ScrollContainer/VBoxContainer/TitleEdit
@onready var DescriptEdit = $PanelContainer/MarginContainer/VBoxContainer/ScrollContainer/VBoxContainer/DescriptionEdit

var title = ""
var description = ""

func Show_window(new_title, new_desc):
	title = new_title
	description = new_desc
	if title != "":
		TitleTextEdit.set_text(title)
	if description !="":
		DescriptEdit.set_text(description)
	self.visible = true


func _on_cancel_pressed() -> void:
	self.visible = false
