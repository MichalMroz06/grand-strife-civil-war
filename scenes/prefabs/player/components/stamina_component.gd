class_name StaminaComponent
extends Node

signal stamina_changed(current: float, max_value: float)

@export var max_stamina: float = 100.0
@export var regen_rate: float = 20.0
@export var regen_delay: float = 0.7

var current_stamina: float
var _delay_timer: float = 0.0

func _ready() -> void:
	current_stamina = max_stamina
	stamina_changed.emit(current_stamina, max_stamina)

func _process(delta: float) -> void:
	if _delay_timer > 0.0:
		_delay_timer -= delta
		return
	if current_stamina < max_stamina:
		current_stamina = min(current_stamina + regen_rate * delta, max_stamina)
		stamina_changed.emit(current_stamina, max_stamina)

func try_consume(amount: float) -> bool:
	if current_stamina < amount:
		return false
	current_stamina -= amount
	_delay_timer = regen_delay
	stamina_changed.emit(current_stamina, max_stamina)
	return true
