extends State

func enter(_prev: String, _data: Dictionary = {}) -> void:
	player.velocity = Vector2.ZERO
	player.animations.play("idle")

func handle_input(event: InputEvent) -> void:
	if event.is_action_pressed("move_dash"):
		transitioned.emit("../dash", {})
	if event.is_action_pressed("action_basic_attack"):
		transitioned.emit("../attack", {})

func physics_update(_delta: float) -> void:
	player.update_aim_facing()
	
	var dir := player.get_input_vector()
	if dir != Vector2.ZERO:
		if Input.is_action_pressed("move_run") and player.stamina.current_stamina > 5.0:
			transitioned.emit("../run", {})
		else:
			transitioned.emit("../move", {})
