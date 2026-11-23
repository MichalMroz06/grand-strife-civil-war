extends CanvasLayer

@onready var hp_bar: ProgressBar = $health_bar
@onready var stamina_bar: ProgressBar = $stamina_bar

@export var player: Player

func _ready() -> void:
	if player == null:
		player = get_parent() as Player
	
	if player == null:
		push_warning("HUD: cannot find player!")
		return
	
	await player.ready
	
	if player.health:
		player.health.health_changed.connect(_on_health_changed)
		_on_health_changed(player.health.current_health, player.health.max_health)
	
	if player.stamina:
		player.stamina.stamina_changed.connect(_on_stamina_changed)
		_on_stamina_changed(player.stamina.current_stamina, player.stamina.max_stamina)

func _on_health_changed(current: float, max_value: float) -> void:
	if hp_bar == null:
		return
	hp_bar.max_value = max_value
	hp_bar.value = current

func _on_stamina_changed(current: float, max_value: float) -> void:
	if stamina_bar == null:
		return
	stamina_bar.max_value = max_value
	stamina_bar.value = current
