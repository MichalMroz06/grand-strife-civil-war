extends Control

@onready var horizontal_slider: HSlider = $vertical_container/horizontal_container/horizontal_slider
@onready var current_fps_limit: Label = $vertical_container/current_fps_limit

func _ready() -> void:
	horizontal_slider.value = Engine.max_fps
	
	_update_fps_display(int(horizontal_slider.value))

func _on_horizontal_slider_value_changed(value: float) -> void:
	var fps_limit: int = int(value)
	
	Settings.fps_limit = fps_limit
	
	Settings.apply_settings()
	Settings.save_settings()
	_update_fps_display(fps_limit)

func _update_fps_display(value: int) -> void:
	if value == 130.0:
		current_fps_limit.text = "Max (Without limit)"
	else:
		current_fps_limit.text = str(value) + " FPS"
