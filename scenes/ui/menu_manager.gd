extends CanvasLayer

@onready var screen_container: Control = $menu_manager/screen_container

@onready var bg_soundtrack_menu_01: AudioStreamPlayer = $"bg-soundtrack-menu-01"
@onready var bg_soundtrack_menu_02: AudioStreamPlayer = $"bg-soundtrack-menu-02"

@export var main_menu_scene: PackedScene = preload("uid://bre176g3lqfq3")
@export var credits_scene: PackedScene = preload("uid://ci2kaobp55ueg")
@export var settings_scene: PackedScene = preload("uid://bce7frqpi7fc")

@export var playlist: Array[AudioStream] = []
var current_track_index: int = 0

var current_screen: Control = null

var active_player: AudioStreamPlayer
var inactive_player: AudioStreamPlayer

func _ready() -> void:
	open_screen(main_menu_scene)
	
	active_player = bg_soundtrack_menu_01
	inactive_player = bg_soundtrack_menu_02
	
	bg_soundtrack_menu_01.finished.connect(_on_track_finished)
	bg_soundtrack_menu_02.finished.connect(_on_track_finished)
	
	if not playlist.is_empty():
		active_player.stream = playlist[current_track_index]
		active_player.volume_db = 0.0
		active_player.play()

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
	open_screen(settings_scene)

func _on_load_game_pressed() -> void:
	print("load_game")

func _on_new_game_pressed() -> void:
	print("new_game")

func _on_exit_btn_pressed() -> void:
	get_tree().quit()


func get_next_song_from_playlist() -> AudioStream:
	if playlist.is_empty():
		return null
	
	current_track_index = (current_track_index + 1) % playlist.size()
	return playlist[current_track_index]

func _on_track_finished() -> void:
	var next_stream = get_next_song_from_playlist()
	if next_stream:
		crossfade_to(next_stream, 3.0)

func crossfade_to(new_stream: AudioStream, duration: float = 2.0) -> void:
	var temp = active_player
	active_player = inactive_player
	inactive_player = temp
	
	inactive_player.stream = new_stream
	inactive_player.volume_db = -80.0
	inactive_player.play()
	
	var tween = create_tween().set_parallel(true)
	tween.tween_property(active_player, "volume_db", -80.0, duration)
	tween.tween_property(inactive_player, "volume_db", 0.0, duration)
	
	tween.chain().tween_callback(active_player.stop)
