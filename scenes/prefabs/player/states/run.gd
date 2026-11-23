extends State

@export var stamina_drain_per_sec: float = 18.0

func enter(_prev: String, _data: Dictionary = {}) -> void:
	player.animations.play("run")

func handle_input(event: InputEvent) -> void:
	if event.is_action_pressed("move_dash"):
		transitioned.emit("../dash", {})
	if event.is_action_pressed("action_basic_attack"):
		transitioned.emit("../attack", {})

func physics_update(delta: float) -> void:
	player.update_aim_facing()
	
	var dir := player.get_input_vector()
	if dir == Vector2.ZERO:
		transitioned.emit("../idle", {})
		return
	
	if not Input.is_action_pressed("move_run") or not player.stamina.try_consume(stamina_drain_per_sec * delta):
		transitioned.emit("../move", {})
		return
	
	player.update_move_animation("move", dir)
	player.velocity = dir * player.run_speed
	player.move_and_slide()
