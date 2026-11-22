extends State

func enter(_prev: String, _data: Dictionary = {}) -> void:
	player.animations.play("move")

func handle_input(event: InputEvent) -> void:
	if event.is_action_pressed("move_dash"):
		transitioned.emit("../dash", {})
	if event.is_action_pressed("action_basic_attack"):
		transitioned.emit("../attack", {})

func physics_update(_delta: float) -> void:
	var dir := player.get_input_vector()
	if dir == Vector2.ZERO:
		transitioned.emit("../idle", {})
		return
	
	if Input.is_action_pressed("move_run") and player.stamina.current_stamina > 5.0:
		transitioned.emit("../run", {})
		return
	
	player.update_facing(dir)
	player.velocity = dir * player.walk_speed
	player.move_and_slide()
