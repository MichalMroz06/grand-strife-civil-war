extends Control

@onready var color_background: ColorRect = $color_background

@onready var current_mission_lbl: Label = $horizontal_container/current_mission_lbl
@onready var save_date_lbl: Label = $horizontal_container/save_date_lbl
@onready var is_autosave_lbl: Label = $horizontal_container/is_autosave_lbl

@export var is_selected: bool = false

signal item_select(file_name: String)

var current_file_name: String

func setup(current_file: String, current_mission: String, save_date: String, is_autosave: bool) -> void:
	current_file_name = current_file
	current_mission_lbl.text = current_mission
	save_date_lbl.text = save_date
	
	if is_autosave:
		is_autosave_lbl.text = "Autosave"
		is_autosave_lbl.modulate = Color.DARK_GRAY
	else:
		is_autosave_lbl.text = "User Save"
		is_autosave_lbl.modulate = Color.GREEN

func _on_file_btn_pressed() -> void:
	item_select.emit(current_file_name)

func _select_file() -> void:
	if is_selected:
		color_background.color = Color(0.0, 0.0, 0.0, 0.2)
		is_selected = false
	else:
		color_background.color = Color(0.0, 0.0, 0.0, 0.4)
		is_selected = true
