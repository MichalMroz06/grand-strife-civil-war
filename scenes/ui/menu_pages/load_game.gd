extends Control

@onready var vertical_container: VBoxContainer = $load_game_section/saved_files_list/scroll_container/vertical_container
@onready var no_files_lbl: Label = $load_game_section/saved_files_list/no_files_lbl
@onready var no_preview_lbl: Label = $load_game_section/info_section/no_preview_lbl

@onready var item_preview: Control = $load_game_section/info_section/item_preview
@onready var current_mission_lbl: Label = $load_game_section/info_section/item_preview/vertical_container/current_mission_lbl
@onready var player_level_value_lbl: Label = $load_game_section/info_section/item_preview/vertical_container/player_level_horizontal_container/player_level_value_lbl
@onready var money_value_lbl: Label = $load_game_section/info_section/item_preview/vertical_container/money_horizontal_container/money_value_lbl
@onready var time_spent_value_lbl: Label = $load_game_section/info_section/item_preview/vertical_container/time_spent_horizontal_container/time_spent_value_lbl
@onready var game_version_lbl: Label = $load_game_section/info_section/item_preview/vertical_container/game_version_lbl

@export var save_folder: String = "user://saves"

signal back_pressed

const SaveSlotScene = preload("uid://d37n8kgjneila")

var resources_dictionary: Dictionary[String, Resource]

var current_game_version: String
var current_file_selected: String
var current_selected_item: Control = null

func _ready():
	current_game_version = DebugInfo.GAME_VERSION
	refresh_save_list()

func _on_back_btn_pressed() -> void:
	back_pressed.emit()

func refresh_save_list() -> void:
	for child in vertical_container.get_children():
		child.queue_free()
		
	var dir: DirAccess = DirAccess.open(save_folder)
	if dir:
		dir.list_dir_begin()
		var file_name: String = dir.get_next()
		var save_files: Array = []
		
		while file_name != "":
			if not dir.current_is_dir() and (file_name.ends_with(".tres") or file_name.ends_with(".res")):
				var full_path: String = save_folder.path_join(file_name)
				var mod_time: int = FileAccess.get_modified_time(full_path)
				save_files.append({"file_name": file_name, "full_path": full_path, "mod_time": mod_time})
				
			file_name = dir.get_next()
		
		save_files.sort_custom(func(a, b): return a["mod_time"] < b["mod_time"])
		
		for file_info in save_files:
			var fname: String = file_info["file_name"]
			var full_path: String = file_info["full_path"]
			var save_res: Resource = ResourceLoader.load(full_path)
			resources_dictionary.set(fname, save_res)
			
			if save_res and "game_version" in save_res:
				var slot_ui: Node = SaveSlotScene.instantiate()
				
				vertical_container.add_child(slot_ui)
				
				slot_ui.setup(fname, save_res.current_mission, save_res.save_date, save_res.is_autosave)
				
				if slot_ui.has_signal("item_select"):
					slot_ui.item_select.connect(func(fname): _on_save_item_pressed(fname, slot_ui))
		
		if resources_dictionary.is_empty():
			no_files_lbl.visible = true
		else:
			no_files_lbl.visible = false

func _on_save_item_pressed(file_name: String, selected_slot: Control) -> void:
	var currently_used_resource: Resource = resources_dictionary[file_name]
	if current_selected_item == selected_slot:
		selected_slot._select_file()
		current_selected_item = null
		current_file_selected = ""
		return
	
	if current_selected_item and is_instance_valid(current_selected_item):
		current_selected_item._select_file()
	
	current_selected_item = selected_slot
	current_selected_item._select_file()
	current_file_selected = file_name
	
	no_preview_lbl.visible = false
	item_preview.visible = true
	
	current_mission_lbl.text = currently_used_resource.current_mission
	player_level_value_lbl.text = str(currently_used_resource.player_level) # IMPORTANT! TEMPORARY
	money_value_lbl.text = str(currently_used_resource.player_money) # IMPORTANT! TEMPORARY
	time_spent_value_lbl.text = str(snapped(currently_used_resource.time_spent / 60.0, 0.5))
	
	if current_game_version == currently_used_resource.game_version:
		game_version_lbl.modulate = Color.GREEN
	else:
		game_version_lbl.modulate = Color.YELLOW
	game_version_lbl.text = currently_used_resource.game_version

func _on_load_game_btn_pressed() -> void:
	print("Selected: ", current_file_selected)
