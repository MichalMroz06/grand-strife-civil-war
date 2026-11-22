class_name Player
extends CharacterBody2D

@export var walk_speed: float = 160.0
@export var run_speed: float = 280.0

var last_direction: Vector2 = Vector2.RIGHT

@onready var sprite: Sprite2D = $Icon
@onready var animations: AnimationPlayer = $animations
@onready var health: HealthComponent = $stats_components/health_component
@onready var stamina: StaminaComponent = $stats_components/stamina_component
@onready var state_machine: StateMachine = $state_machine
@onready var attack_hitbox: Area2D = $attack_hitbox

func _ready() -> void:
	motion_mode = CharacterBody2D.MOTION_MODE_FLOATING
	health.died.connect(_on_died)

func get_input_vector() -> Vector2:
	return Input.get_vector("move_left", "move_right", "move_up", "move_down")

func update_facing(dir: Vector2) -> void:
	if dir == Vector2.ZERO:
		return
	last_direction = dir.normalized()
	if sprite:
		sprite.flip_h = dir.x < 0.0

func take_hit(damage: float, knockback: Vector2 = Vector2.ZERO) -> void:
	if health.current_health <= 0.0:
		return
	health.take_damage(damage)
	if health.current_health > 0.0:
		state_machine.transition_to("hurt", {"knockback": knockback})

func _on_died() -> void:
	state_machine.transition_to("dead", {})
