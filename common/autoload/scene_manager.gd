extends Node

const LOADING_SCENE_PATH := "res://scenes/ui/loadig_screen.tscn"

var target_scene_path: String = ""
var save_path: String = ""
var loaded_save_data: Dictionary = {}

func go_to_scene(p_target_scene_path: String, p_save_path: String = "") -> void:
	if p_target_scene_path.is_empty():
		push_error("SceneManager.go_to_scene: pusta ścieżka docelowej sceny.")
		return
	
	target_scene_path = p_target_scene_path
	save_path = p_save_path
	loaded_save_data.clear()
	
	if LOADING_SCENE_PATH.is_empty() or not ResourceLoader.exists(LOADING_SCENE_PATH):
		push_error("Brak lub niepoprawna ścieżka sceny ładowania: '%s'" % LOADING_SCENE_PATH)
		return
	
	get_tree().call_deferred("change_scene_to_file", LOADING_SCENE_PATH)
