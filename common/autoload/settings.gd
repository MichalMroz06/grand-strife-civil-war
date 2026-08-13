extends Node

var SETTINGS_FILE: String = "user://settings.cfg"

var current_resolution: Vector2i = Vector2i(1920, 1080)
var is_borderless: bool = true
var is_fullscreen: bool = false

var is_debug: bool = true

var cursor_arrow_img: Image = load("uid://b3agsl50vu61j").get_image()
const REFERENCE_HEIGHT: float = 360.0
const BASE_CURSOR_SIZE: int = 16

func _ready():
	load_settings()
	apply_settings.call_deferred()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("debug_toggle"):
		if is_debug:
			is_debug = false
		else:
			is_debug = true
		apply_settings()
		save_settings()

func update_cursors_scale() -> void:
	var window_height := float(get_window().size.y)
	
	var scale_factor: float = window_height / REFERENCE_HEIGHT
	var new_size: int = int(BASE_CURSOR_SIZE * scale_factor)
	new_size = clampi(new_size, 16, 128)
	
	var scaled_arrow: ImageTexture = scale_image(cursor_arrow_img, new_size)
	Input.set_custom_mouse_cursor(scaled_arrow, Input.CURSOR_ARROW)

func scale_image(source_img: Image, target_size: int) -> ImageTexture:
	var img_copy: Image = source_img.duplicate()
	img_copy.resize(target_size, target_size, Image.INTERPOLATE_LANCZOS)
	return ImageTexture.create_from_image(img_copy)

func apply_settings() -> void:
	if is_fullscreen:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	elif is_borderless:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		DisplayServer.window_set_size(current_resolution)
		var current_screen := DisplayServer.window_get_current_screen()
		var screen_half_size := Vector2i(Vector2(DisplayServer.screen_get_size(current_screen)) / 2.0)
		var screen_center := DisplayServer.screen_get_position(current_screen) + screen_half_size
		var window_half_size := Vector2i(Vector2(current_resolution) / 2.0)
		DisplayServer.window_set_position(screen_center - window_half_size)
	
	update_cursors_scale()
	DebugInfo.set_debug_status()

func save_settings() -> void:
	var config := ConfigFile.new()
	
	config.set_value("video", "resolution_x", current_resolution.x)
	config.set_value("video", "resolution_y", current_resolution.y)
	config.set_value("video", "borderless", is_borderless)
	config.set_value("video", "fullscreen", is_fullscreen)
	
	config.set_value("debug", "is_debug", is_debug)
	
	config.save(SETTINGS_FILE)

func load_settings() -> void:
	var config := ConfigFile.new()
	var err := config.load(SETTINGS_FILE)
	
	if err == OK:
		current_resolution.x = config.get_value("video", "resolution_x", current_resolution.x)
		current_resolution.y = config.get_value("video", "resolution_y", current_resolution.y)
		is_borderless = config.get_value("video", "borderless", is_borderless)
		is_fullscreen = config.get_value("video", "fullscreen", is_fullscreen)
		
		is_debug = config.get_value("debug", "is_debug", is_debug)
	else:
		save_settings()
