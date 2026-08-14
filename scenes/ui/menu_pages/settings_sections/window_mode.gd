extends Control

@onready var current_mode_lbl: Label = $horizontal_container/vertical_container/header_container/horizontal_container/current_mode_lbl
@onready var collapse_expand_btn: TextureButton = $horizontal_container/vertical_container/header_container/horizontal_container/collapse_expand_btn
@onready var list_container: PanelContainer = $horizontal_container/vertical_container/list_container
@onready var vertical_container: VBoxContainer = $horizontal_container/vertical_container/list_container/vertical_container
@onready var btn_template: TextureButton = $horizontal_container/vertical_container/list_container/vertical_container/option_1_btn

@export var modes: Array[String] = [
	"Fullscreen",
	"Borderless",
	"Windowed"
]

@export var texture_arrow_closed: Texture2D
@export var texture_arrow_opened: Texture2D

func _ready() -> void:
	if Settings.is_fullscreen:
		current_mode_lbl.text = "Fullscreen"
	elif Settings.is_borderless:
		current_mode_lbl.text = "Borderless"
	else:
		current_mode_lbl.text = "Windowed"
	
	generate_mode_list()
	
	btn_template.visible = false
	list_container.visible = false
	update_toggle_texture()

func _on_collapse_expand_btn_pressed() -> void:
	list_container.visible = !list_container.visible
	update_toggle_texture()

func generate_mode_list() -> void:
	for mode in modes:
		var new_btn: TextureButton = btn_template.duplicate() as TextureButton
		new_btn.visible = true
		
		var btn_label: Label = new_btn.get_node_or_null("option_1_btn_lbl")
		if btn_label:
			btn_label.text = mode
		
		vertical_container.add_child(new_btn)
		
		new_btn.pressed.connect(on_mode_selected.bind(mode))

func on_mode_selected(new_mode: String) -> void:
	current_mode_lbl.text = new_mode
	
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
			collapse_expand_btn.texture_normal = texture_arrow_opened
		else:
			collapse_expand_btn.texture_normal = texture_arrow_closed
