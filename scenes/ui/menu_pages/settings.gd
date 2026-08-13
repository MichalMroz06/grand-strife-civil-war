extends Control

signal back_pressed

func _on_back_btn_pressed() -> void:
	back_pressed.emit()

func _on_video_btn_pressed() -> void:
	print("video")

func _on_audio_btn_pressed() -> void:
	print("audio")

func _on_controls_btn_pressed() -> void:
	print("controls")
