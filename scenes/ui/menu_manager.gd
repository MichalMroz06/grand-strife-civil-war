extends CanvasLayer

@onready var screen_container: Control = $menu_manager/screen_container

@export var main_menu_scene: PackedScene = preload("uid://bre176g3lqfq3")
@export var credits_scene: PackedScene = preload("uid://ci2kaobp55ueg")
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
	
	if current_screen.has_signal("credits_pressed"):
		current_screen.credits_pressed.connect(_on_credits_pressed)
	
	if current_screen.has_signal("settings_pressed"):
		current_screen.settings_pressed.connect(_on_settings_pressed)
	
	if current_screen.has_signal("load_game_pressed"):
		current_screen.load_game_pressed.connect(_on_load_game_pressed)
	
	if current_screen.has_signal("new_game_pressed"):
		current_screen.new_game_pressed.connect(_on_new_game_pressed)

func _on_back_pressed() -> void:
	open_screen(main_menu_scene)

func _on_credits_pressed() -> void:
	open_screen(credits_scene)

func _on_settings_pressed() -> void:
	print("settings")

func _on_load_game_pressed() -> void:
	print("load_game")

func _on_new_game_pressed() -> void:
	print("new_game")

func _on_exit_btn_pressed() -> void:
	get_tree().quit()
