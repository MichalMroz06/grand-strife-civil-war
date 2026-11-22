extends Control

@export var story_mode_section: PackedScene = preload("uid://ce7e1f7cwtoau")

@onready var new_game_section: Control = $new_game_section
@onready var color_background: ColorRect = $new_game_section/color_background

signal back_pressed

var current_screen: Control = null

func _ready() -> void:
	color_background.visible = false

func _on_back_btn_pressed() -> void:
	back_pressed.emit()

func open_section(new_scene: PackedScene) -> void:
	if current_screen:
		current_screen.queue_free()
	else:
		color_background.visible = true
	
	current_screen = new_scene.instantiate()
	new_game_section.add_child(current_screen)

func _on_story_mode_btn_pressed() -> void:
	open_section(story_mode_section)

func _on_sandbox_btn_pressed() -> void:
	print("Sandbox section")

func _on_tutorial_btn_pressed() -> void:
	print("Tutorial loading...")
