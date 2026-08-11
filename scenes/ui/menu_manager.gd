extends CanvasLayer

@onready var screen_container: Control = $main_menu/screen_container

@export var main_menu_scene: PackedScene = preload("uid://bre176g3lqfq3")
@export var credits_scene: PackedScene
@export var settings_scene: PackedScene
var current_screen: Control = null

func _ready() -> void:
	open_screen(main_menu_scene)

func open_screen(new_scene: PackedScene) -> void:
	if current_screen:
		current_screen.queue_free()
		
	current_screen = new_scene.instantiate()
	screen_container.add_child(current_screen)
	
	if current_screen.has_signal("back_pressed"):
		current_screen.back_pressed.connect(_on_back_pressed)

func _on_back_pressed() -> void:
	open_screen(main_menu_scene)

func _on_exit_btn_pressed() -> void:
	get_tree().quit()
