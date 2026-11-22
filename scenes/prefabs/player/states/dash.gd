extends State

@export var dash_speed: float = 650.0
@export var dash_duration: float = 0.16
@export var energy_cost: float = 25.0

var _timer: float = 0.0
var _dash_dir: Vector2 = Vector2.DOWN

func enter(_prev: String, _data: Dictionary = {}) -> void:
	if not player.stamina.try_consume(energy_cost):
		transitioned.emit("../idle", {})
		return
	
	_timer = dash_duration
	var input_dir: Vector2 = player.get_input_vector()
	_dash_dir = input_dir.normalized() if input_dir != Vector2.ZERO else player.last_direction
	
	player.update_facing(_dash_dir)
	player.velocity = _dash_dir * dash_speed
	player.animations.play("dash")

func physics_update(delta: float) -> void:
	_timer -= delta
	player.move_and_slide()
	
	if _timer <= 0.0:
		if player.get_input_vector() != Vector2.ZERO:
			transitioned.emit("../move", {})
		else:
			transitioned.emit("../idle", {})
