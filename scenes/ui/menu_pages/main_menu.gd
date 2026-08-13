extends Control

signal credits_pressed
signal settings_pressed
signal load_game_pressed
signal new_game_pressed

func _on_credits_btn_pressed() -> void:
	credits_pressed.emit()

func _on_settings_btn_pressed() -> void:
	settings_pressed.emit()

func _on_load_game_btn_pressed() -> void:
	load_game_pressed.emit()

func _on_new_game_btn_pressed() -> void:
	new_game_pressed.emit()
