extends State

@export var stamina_cost: float = 15.0
@export var attack_duration: float = 0.28

var _timer: float = 0.0

func enter(_prev: String, _data: Dictionary = {}) -> void:
	if not player.stamina.try_consume(stamina_cost):
		transitioned.emit("../idle", {})
		return

	_timer = attack_duration
	player.velocity = Vector2.ZERO
	player.attack_hitbox.rotation = player.last_direction.angle()
	player.animations.play("attack")
	player.attack_hitbox.monitoring = true

func exit() -> void:
	player.attack_hitbox.monitoring = false

func physics_update(delta: float) -> void:
	_timer -= delta
	if _timer <= 0.0:
		if player.get_input_vector() != Vector2.ZERO:
			transitioned.emit("../move", {})
		else:
			transitioned.emit("../idle", {})
