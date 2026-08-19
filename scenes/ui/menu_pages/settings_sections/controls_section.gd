extends Control

@export var editable_actions: Dictionary = {
	"others": [
		"debug_toggle"
	]
}

@export var remap_button_scene: PackedScene = preload("uid://bgn8fa4n7nity")
@export var paragraph_lbl_theme: Theme = preload("uid://ctmoqufcoiv4m")
@export var header_lbl_theme: Theme = preload("uid://2lmkqmj0ljkf")

@onready var vertical_container: VBoxContainer = $container/scroll_container/vertical_container

func _ready() -> void:
	create_action_list()

func create_action_list() -> void:
	for child in vertical_container.get_children():
		child.queue_free()
	
	for section_name in editable_actions:
		var actions: Array = editable_actions[section_name]
		
		create_section_header(section_name)
		
		for action in actions:
			if not InputMap.has_action(action):
				continue
			
			var margin_container = MarginContainer.new()
			margin_container.size_flags_horizontal = Control.SIZE_EXPAND_FILL
			margin_container.add_theme_constant_override("margin_left", 20)
			
			var row = HBoxContainer.new()
			row.size_flags_horizontal = Control.SIZE_EXPAND_FILL
			
			var label = Label.new()
			label.text = action.capitalize()
			label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
			label.custom_minimum_size = Vector2i(80, 0)
			if paragraph_lbl_theme:
				label.theme = paragraph_lbl_theme
			
			var remap_button: TextureButton = remap_button_scene.instantiate()
			remap_button.setup(action, self)
			remap_button.custom_minimum_size = Vector2i(120, 0)
			
			margin_container.add_child(row)
			row.add_child(label)
			row.add_child(remap_button)
			
			vertical_container.add_child(margin_container)

func create_section_header(title: String) -> void:
	if vertical_container.get_child_count() > 0:
		var separator = HSeparator.new()
		vertical_container.add_child(separator)

	var header_label = Label.new()
	header_label.text = title.capitalize() + ":"
	if header_lbl_theme:
		header_label.theme = header_lbl_theme
	
	vertical_container.add_child(header_label)

func get_readable_key_name(action_name: String) -> String:
	var events = InputMap.action_get_events(action_name)
	if events.is_empty():
		return "Null"
	
	var event = events[0]
	
	if event is InputEventKey:
		var key_code = event.physical_keycode if event.physical_keycode != KEY_NONE else event.keycode
		return OS.get_keycode_string(key_code)
	
	if event is InputEventMouseButton:
		match event.button_index:
			MOUSE_BUTTON_LEFT: return "LMB"
			MOUSE_BUTTON_RIGHT: return "RMB"
			MOUSE_BUTTON_MIDDLE: return "MMB"
			MOUSE_BUTTON_XBUTTON1: return "Mouse 4"
			MOUSE_BUTTON_XBUTTON2: return "Mouse 5"
			_: return "Mouse " + str(event.button_index)
	
	return event.as_text().split("(")[0].strip_edges()
