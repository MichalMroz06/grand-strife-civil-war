class_name StateMachine
extends Node

@export var initial_state: State
@export var player: Player

var current_state: State

func _ready() -> void:
	await owner.ready
	for child: Node in get_children():
		if child is State:
			var state_node: State = child
			state_node.player = player
			state_node.transitioned.connect(_on_state_transitioned)
	if initial_state:
		current_state = initial_state
		current_state.enter("")

func _unhandled_input(event: InputEvent) -> void:
	if current_state:
		current_state.handle_input(event)

func _process(delta: float) -> void:
	if current_state:
		current_state.update(delta)

func _physics_process(delta: float) -> void:
	if current_state:
		current_state.physics_update(delta)

func _on_state_transitioned(target_state_path: String, data: Dictionary = {}) -> void:
	if current_state == null:
		return
	
	var clean_name: String = target_state_path.get_file()
	var new_state: State = get_node_or_null(clean_name) as State
	
	if new_state == null:
		push_warning("StateMachine: cannot find state: '" + clean_name + "' (path: " + target_state_path + ")")
		return
	
	if new_state == current_state:
		return
	
	current_state.exit()
	var previous_path: String = current_state.name
	current_state = new_state
	current_state.enter(previous_path, data)
