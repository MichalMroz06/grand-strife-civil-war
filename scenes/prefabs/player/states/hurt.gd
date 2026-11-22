extends State

@export var stun_duration: float = 0.22

var _timer: float = 0.0

func enter(_prev: String, data: Dictionary = {}) -> void:
	_timer = stun_duration
	player.velocity = data.get("knockback", Vector2.ZERO)
	player.animations.play("hurt")

func physics_update(delta: float) -> void:
	player.velocity = player.velocity.move_toward(Vector2.ZERO, 700.0 * delta)
	player.move_and_slide()

	_timer -= delta
	if _timer <= 0.0:
		transitioned.emit("../idle", {})
