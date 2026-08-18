extends Control

@onready var credits_lbl: MarkdownLabel = $credits_section/credits_lbl

@export var credits_lbl_md_path: String = "res://scenes/ui/menu_pages/credits_lbls/credits_lbl.md"
@export var art_and_graphics_lbl_md_path: String = "res://scenes/ui/menu_pages/credits_lbls/art_and_graphics_lbl.md"
@export var music_and_sound_effects_lbl_md_path: String = "res://scenes/ui/menu_pages/credits_lbls/music_and_sound_effects.md"
@export var fonts_lbl_md_path: String = "res://scenes/ui/menu_pages/credits_lbls/fonts_lbl.md"

signal back_pressed

func _ready() -> void:
	var credits_lbl_content: String = load_credits_file(credits_lbl_md_path)
	credits_lbl.markdown_text = credits_lbl_content

func _on_back_btn_pressed() -> void:
	back_pressed.emit()

func load_credits_file(path: String) -> String:
	if FileAccess.file_exists(path):
		var file: FileAccess = FileAccess.open(path, FileAccess.READ)
		var markdown_text: String = file.get_as_text()
		file.close()
		
		return markdown_text
	else:
		return "**ERROR!** File not found on path: `" + path + "`"

func _on_main_credits_btn_pressed() -> void:
	var credits_lbl_content: String = load_credits_file(credits_lbl_md_path)
	credits_lbl.markdown_text = credits_lbl_content

func _on_art_and_graphics_btn_pressed() -> void:
	var credits_lbl_content: String = load_credits_file(art_and_graphics_lbl_md_path)
	credits_lbl.markdown_text = credits_lbl_content

func _on_music_and_sound_effects_btn_pressed() -> void:
	var credits_lbl_content: String = load_credits_file(music_and_sound_effects_lbl_md_path)
	credits_lbl.markdown_text = credits_lbl_content

func _on_fonts_btn_pressed() -> void:
	var credits_lbl_content: String = load_credits_file(fonts_lbl_md_path)
	credits_lbl.markdown_text = credits_lbl_content
