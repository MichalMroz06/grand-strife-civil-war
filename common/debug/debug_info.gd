extends CanvasLayer

@onready var version_lbl: Label = $container/debug_info/vertical_container/version_lbl
@onready var fps_lbl: Label = $container/debug_info/vertical_container/fps_lbl

@export var game_version: String = "0.1.1-dev"
@export var update_interval: float = 0.1

var _time_passed: float = 0.0

func _ready() -> void:
	version_lbl.text = "Version: " + game_version

func _process(delta: float) -> void:
	_time_passed += delta
	if _time_passed >= update_interval:
		_time_passed = 0.0
		update_info_text()

func set_debug_status() -> void:
	if Settings.is_debug:
		$container.visible = true
	else:
		$container.visible = false

func update_info_text() -> void:
	var fps: int = int(Engine.get_frames_per_second())
	fps_lbl.text = "FPS: " + str(fps)
