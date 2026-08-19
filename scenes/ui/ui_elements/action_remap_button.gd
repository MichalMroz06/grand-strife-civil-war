extends TextureButton

@onready var key_lbl: Label = $key_lbl

var action_name: String = ""
var parent_menu: Control

func setup(p_action_name: String, p_parent_menu: Control) -> void:
	action_name = p_action_name
	parent_menu = p_parent_menu
	set_process_unhandled_input(false)
	update_text()

func _on_pressed() -> void:
	key_lbl.text = "[ ... ]"
	set_process_unhandled_input(true)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion or not event.is_pressed():
		return
		
	InputMap.action_erase_events(action_name)
	InputMap.action_add_event(action_name, event)
	
	Settings.save_action_keybinding(action_name, event)
	
	set_process_unhandled_input(false)
	get_viewport().set_input_as_handled()
	update_text()

func update_text() -> void:
	if not key_lbl:
		key_lbl = get_node_or_null("key_lbl") as Label
	
	if not key_lbl:
		return
	
	if parent_menu and parent_menu.has_method("get_readable_key_name"):
		key_lbl.text = parent_menu.get_readable_key_name(action_name)
	else:
		var events = InputMap.action_get_events(action_name)
		key_lbl.text = events[0].as_text() if not events.is_empty() else "Null"
