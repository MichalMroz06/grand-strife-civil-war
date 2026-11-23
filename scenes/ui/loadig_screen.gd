extends Control

@onready var progress_bar: ProgressBar = $bottom_section/progress_bar
@onready var status_lbl: Label = $bottom_section/horizontal_container/status_lbl
@onready var hints_lbl: Label = $bottom_section/horizontal_container/hints_lbl

@export var rotate_hints: bool = true
@export var hint_interval: float = 4.0

var scene_path: String = ""
var save_path: String = ""
var progress: Array = []
var is_done: bool = false
var hint_timer: float = 0.0
var last_hint_index: int = -1

const hints: Array[String] = [
	"LOADING_SCENE_HINT_01",
	"LOADING_SCENE_HINT_02",
	"LOADING_SCENE_HINT_03",
	"LOADING_SCENE_HINT_04",
	"LOADING_SCENE_HINT_05"
]

func _ready() -> void:
	show_random_hint()
	
	scene_path = SceneManager.target_scene_path
	save_path = SceneManager.save_path
	
	if scene_path.is_empty() or not ResourceLoader.exists(scene_path):
		push_error("Wrong destination scene: '%s'" % scene_path)
		return
	
	var err := ResourceLoader.load_threaded_request(scene_path)
	if err != OK:
		push_error("Cannot load in background: %s" % error_string(err))
		return
	
	set_process(true)

func _process(delta: float) -> void:
	if is_done:
		return
	
	if rotate_hints and hints.size() > 1:
		hint_timer += delta
		if hint_timer >= hint_interval:
			hint_timer = 0.0
			show_random_hint()
	
	var status := ResourceLoader.load_threaded_get_status(scene_path, progress)
	
	match status:
		ResourceLoader.THREAD_LOAD_IN_PROGRESS:
			if progress.size() > 0 and progress_bar:
				progress_bar.value = float(progress[0]) * 100.0
			if status_lbl:
				status_lbl.text = "LOADING_SCENE_LOADING_SCENE"
	
		ResourceLoader.THREAD_LOAD_LOADED:
			is_done = true
			set_process(false)
			if progress_bar:
				progress_bar.value = 100.0
			
			# --- Only for TESTS! 5 sec timeout ---
			await get_tree().create_timer(5).timeout
			if not is_inside_tree():
				return
			# ---------------------------------------------------
			
			finalize_transition()
	
		ResourceLoader.THREAD_LOAD_FAILED, ResourceLoader.THREAD_LOAD_INVALID_RESOURCE:
			is_done = true
			set_process(false)
			push_error("Cannot load scene: %s" % scene_path)
			if status_lbl:
				status_lbl.text = "LOADING_SCENE_LOADING_ERROR"

func finalize_transition() -> void:
	var packed_scene := ResourceLoader.load_threaded_get(scene_path) as PackedScene
	if packed_scene == null:
		push_error("Loaded source is not PackedScene: %s" % scene_path)
		return
	
	if not save_path.is_empty():
		if status_lbl:
			status_lbl.text = "LOADING_SCENE_LOADING_SAVE"
		var save_data := load_save_file(save_path)
		SceneManager.loaded_save_data = save_data
	
	var next_scene := packed_scene.instantiate()
	
	if not SceneManager.loaded_save_data.is_empty() and next_scene.has_method("apply_save_data"):
		next_scene.apply_save_data(SceneManager.loaded_save_data)
	
	var tree := get_tree()
	var old_scene := tree.current_scene
	tree.root.add_child(next_scene)
	tree.current_scene = next_scene
	
	SceneManager.target_scene_path = ""
	SceneManager.save_path = ""
	
	if is_instance_valid(old_scene):
		old_scene.queue_free()


func load_save_file(path: String) -> Dictionary:
	if not FileAccess.file_exists(path):
		push_warning("Save file doesn't exist: %s" % path)
		return {}
	
	var file := FileAccess.open(path, FileAccess.READ)
	if file == null:
		push_error("Cannot open save file (%s): %s" % [path, error_string(FileAccess.get_open_error())])
		return {}
	
	var text := file.get_as_text()
	var parsed: Variant = JSON.parse_string(text)
	if parsed is Dictionary:
		return parsed
	
	push_error("Invalid save data: %s" % path)
	return {}

func show_random_hint() -> void:
	if hints_lbl == null or hints.is_empty():
		return
	
	if hints.size() == 1:
		hints_lbl.text = hints[0]
		return
	
	var idx: int = randi() % hints.size()
	if idx == last_hint_index:
		idx = (idx + 1) % hints.size()
	
	last_hint_index = idx
	hints_lbl.text = hints[idx]
