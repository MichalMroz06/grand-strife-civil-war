class_name State
extends Node

signal transitioned(state_path: String, data: Dictionary)

var player: Player

func enter(_previous_state_path: String, _data: Dictionary = {}) -> void:
	pass

func exit() -> void:
	pass

func handle_input(_event: InputEvent) -> void:
	pass

func update(_delta: float) -> void:
	pass

func physics_update(_delta: float) -> void:
	pass
