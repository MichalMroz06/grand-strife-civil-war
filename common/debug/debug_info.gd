extends CanvasLayer

@onready var version_lbl: Label = $container/debug_info/vertical_container/version_lbl
@onready var fps_lbl: Label = $container/debug_info/vertical_container/fps_lbl

@export var game_version: String = "v0.1.0-dev"
@export var update_interval: float = 0.1

var _time_passed: float = 0.0

func _ready() -> void:
	version_lbl.text = "Game version: " + game_version

func _process(delta: float) -> void:
	_time_passed += delta
	if _time_passed >= update_interval:
		_time_passed = 0.0
		update_info_text()

func update_info_text() -> void:
	var fps: int = Engine.get_frames_per_second()
	fps_lbl.text = "FPS: " + str(fps)
