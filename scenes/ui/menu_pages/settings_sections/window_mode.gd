extends Control

@onready var current_mode_lbl: Label = $horizontal_container/vertical_container/header_container/horizontal_container/collapse_expand_btn/horizontal_container/current_mode_lbl
@onready var collapse_expand_texture: TextureRect = $horizontal_container/vertical_container/header_container/horizontal_container/collapse_expand_btn/horizontal_container/collapse_expand_texture
@onready var collapse_expand_btn: Button = $horizontal_container/vertical_container/header_container/horizontal_container/collapse_expand_btn
@onready var list_container: PanelContainer = $horizontal_container/vertical_container/list_container
@onready var vertical_container: VBoxContainer = $horizontal_container/vertical_container/list_container/vertical_container
@onready var btn_template: Button = $horizontal_container/vertical_container/list_container/vertical_container/option_1_btn

@export var modes: Array[String] = [
	"Fullscreen",
	"Borderless",
	"Windowed"
]

@export var texture_arrow_closed: Texture2D = preload("uid://cs3jumq7ej6uc")
@export var texture_arrow_opened: Texture2D = preload("uid://cf6rpafrywe3g")

const MODE_TRANSLATIONS = {
	"Fullscreen": "SETTINGS_VIDEO_MODE_FULLSCREEN",
	"Borderless": "SETTINGS_VIDEO_MODE_BORDERLESS",
	"Windowed": "SETTINGS_VIDEO_MODE_WINDOWED"
}

func get_mode_text(mode_name: String) -> String:
	return tr(MODE_TRANSLATIONS.get(mode_name, mode_name))

func _ready() -> void:
	if Settings.is_fullscreen:
		current_mode_lbl.text = get_mode_text("Fullscreen")
	elif Settings.is_borderless:
		current_mode_lbl.text = get_mode_text("Borderless")
	else:
		current_mode_lbl.text = get_mode_text("Windowed")
	
	generate_mode_list()
	
	btn_template.visible = false
	list_container.visible = false
	update_toggle_texture()

func _on_collapse_expand_btn_pressed() -> void:
	list_container.visible = !list_container.visible
	update_toggle_texture()

func generate_mode_list() -> void:
	for mode in modes:
		var new_btn: Button = btn_template.duplicate() as Button
		new_btn.visible = true
		
		var btn_label: Label = new_btn.get_node_or_null("option_1_btn_lbl")
		if btn_label:
			btn_label.text = get_mode_text(mode)
		
		vertical_container.add_child(new_btn)
		
		new_btn.pressed.connect(on_mode_selected.bind(mode))

func on_mode_selected(new_mode: String) -> void:
	current_mode_lbl.text = get_mode_text(new_mode)
	
	if new_mode == "Fullscreen":
		Settings.is_fullscreen = true
		Settings.is_borderless = false
		Settings.current_resolution = DisplayServer.screen_get_size()
	elif new_mode == "Borderless":
		Settings.is_fullscreen = false
		Settings.is_borderless = true
		Settings.current_resolution = DisplayServer.screen_get_size()
	else:
		Settings.is_fullscreen = false
		Settings.is_borderless = false
	
	Settings.apply_settings()
	Settings.save_settings()
	
	list_container.visible = false
	update_toggle_texture()

func update_toggle_texture() -> void:
	if texture_arrow_closed and texture_arrow_opened:
		if list_container.visible:
			collapse_expand_texture.texture= texture_arrow_opened
		else:
			collapse_expand_texture.texture = texture_arrow_closed
