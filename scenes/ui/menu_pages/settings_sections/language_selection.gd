extends Control

@onready var current_lang_lbl: Label = $horizontal_container/vertical_container/header_container/horizontal_container/current_lang_lbl
@onready var collapse_expand_btn: TextureButton = $horizontal_container/vertical_container/header_container/horizontal_container/collapse_expand_btn
@onready var list_container: PanelContainer = $horizontal_container/vertical_container/list_container
@onready var vertical_container: VBoxContainer = $horizontal_container/vertical_container/list_container/vertical_container
@onready var btn_template: TextureButton = $horizontal_container/vertical_container/list_container/vertical_container/option_1_btn

@export var languages: Dictionary = {
	"en": "English",
	"pl": "Polski"
}

@export var texture_arrow_closed: Texture2D
@export var texture_arrow_opened: Texture2D

func _ready() -> void:
	update_current_language_display()
	generate_language_list()
	
	btn_template.visible = false
	list_container.visible = false
	update_toggle_texture()

func _on_collapse_expand_btn_pressed() -> void:
	list_container.visible = !list_container.visible
	update_toggle_texture()

func update_current_language_display() -> void:
	var code = Settings.current_locale
	current_lang_lbl.text = languages.get(code, code.to_upper())

func generate_language_list() -> void:
	for code in languages:
		var lang_name: String = languages[code]
		var new_btn: TextureButton = btn_template.duplicate() as TextureButton
		new_btn.visible = true
		
		var btn_label: Label = new_btn.get_node_or_null("option_1_btn_lbl")
		if btn_label:
			btn_label.text = lang_name
		
		vertical_container.add_child(new_btn)
		
		new_btn.pressed.connect(on_language_selected.bind(code))

func on_language_selected(new_locale: String) -> void:
	Settings.current_locale = new_locale
	Settings.apply_settings()
	Settings.save_settings()
	
	update_current_language_display()
	
	list_container.visible = false
	update_toggle_texture()

func update_toggle_texture() -> void:
	if texture_arrow_closed and texture_arrow_opened:
		if list_container.visible:
			collapse_expand_btn.texture_normal = texture_arrow_opened
		else:
			collapse_expand_btn.texture_normal = texture_arrow_closed
