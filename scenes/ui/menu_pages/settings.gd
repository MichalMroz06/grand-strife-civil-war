extends Control

@onready var video_section: PackedScene = preload("uid://lai6x5kklqk1")

@onready var settings_section: Control = $settings_section
@onready var color_background: ColorRect = $settings_section/color_background

signal back_pressed

var current_screen: Control = null

func _ready() -> void:
	color_background.visible = false

func open_section(new_scene: PackedScene) -> void:
	if current_screen:
		current_screen.queue_free()
	else:
		color_background.visible = true
	
	current_screen = new_scene.instantiate()
	settings_section.add_child(current_screen)

func _on_back_btn_pressed() -> void:
	back_pressed.emit()

func _on_video_btn_pressed() -> void:
	open_section(video_section)

func _on_audio_btn_pressed() -> void:
	print("audio")

func _on_controls_btn_pressed() -> void:
	print("controls")
