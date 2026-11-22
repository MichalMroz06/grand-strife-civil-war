extends Control

@onready var default_difficulty_lbl: Label = $horizontal_container/vertical_container/header_container/collapse_expand_btn/horizontal_container/default_difficulty_lbl
@onready var collapse_expand_texture: TextureRect = $horizontal_container/vertical_container/header_container/collapse_expand_btn/horizontal_container/collapse_expand_texture
@onready var list_container: PanelContainer = $horizontal_container/vertical_container/list_container
@onready var vertical_container: VBoxContainer = $horizontal_container/vertical_container/list_container/vertical_container
@onready var btn_template: Button = $horizontal_container/vertical_container/list_container/vertical_container/option_1_btn

@export var difficulties: Dictionary = {
	"Easy": "NEW_GAME_STORY_EASY",
	"Medium": "NEW_GAME_STORY_MEDIUM",
	"Hard": "NEW_GAME_STORY_HARD",
	"Imposible": "NEW_GAME_STORY_IMPOSIBLE"
}

@export var texture_arrow_closed: Texture2D = preload("uid://cs3jumq7ej6uc")
@export var texture_arrow_opened: Texture2D = preload("uid://cf6rpafrywe3g")

func _ready() -> void:
	update_current_difficulties_display()
	generate_difficulties_list()
	
	btn_template.visible = false
	list_container.visible = false
	update_toggle_texture()

func _on_collapse_expand_btn_pressed() -> void:
	list_container.visible = !list_container.visible
	update_toggle_texture()

func update_current_difficulties_display() -> void:
	var code = "Medium"
	default_difficulty_lbl.text = difficulties.get(code, code.to_upper())

func generate_difficulties_list() -> void:
	for code in difficulties:
		var lang_name: String = difficulties[code]
		var new_btn: Button = btn_template.duplicate() as Button
		new_btn.visible = true
		
		var btn_label: Label = new_btn.get_node_or_null("option_1_btn_lbl")
		if btn_label:
			btn_label.text = lang_name
		
		vertical_container.add_child(new_btn)
		
		new_btn.pressed.connect(on_difficulties_selected.bind(code))

func on_difficulties_selected(new_locale: String) -> void:
	Settings.current_locale = new_locale
	Settings.apply_settings()
	Settings.save_settings()
	
	update_current_difficulties_display()
	
	list_container.visible = false
	update_toggle_texture()

func update_toggle_texture() -> void:
	if texture_arrow_closed and texture_arrow_opened:
		if list_container.visible:
			collapse_expand_texture.texture = texture_arrow_opened
		else:
			collapse_expand_texture.texture = texture_arrow_closed
