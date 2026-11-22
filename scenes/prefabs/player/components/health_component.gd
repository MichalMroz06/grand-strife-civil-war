class_name HealthComponent
extends Node

signal health_changed(current: float, max_value: float)
signal died

@export var max_health: float = 100.0
@export var invulnerability_time: float = 0.5

var current_health: float
var _invuln_timer: float = 0.0

func _ready() -> void:
	current_health = max_health
	health_changed.emit(current_health, max_health)

func _process(delta: float) -> void:
	if _invuln_timer > 0.0:
		_invuln_timer -= delta

func take_damage(amount: float) -> void:
	if amount <= 0.0 or current_health <= 0.0 or _invuln_timer > 0.0:
		return
	current_health = max(current_health - amount, 0.0)
	_invuln_timer = invulnerability_time
	health_changed.emit(current_health, max_health)
	if current_health <= 0.0:
		died.emit()

func heal(amount: float) -> void:
	if amount <= 0.0 or current_health <= 0.0:
		return
	current_health = min(current_health + amount, max_health)
	health_changed.emit(current_health, max_health)
