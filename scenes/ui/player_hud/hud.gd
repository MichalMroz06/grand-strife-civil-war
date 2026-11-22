extends CanvasLayer

@onready var hp_bar: ProgressBar = $health_bar
@onready var stamina_bar: ProgressBar = $stamina_bar

func bind_player(player: Node) -> void:
	if player.has_node("HealthComponent"):
		var hp := player.get_node("HealthComponent") as HealthComponent
		hp.health_changed.connect(_on_health_changed)
		_on_health_changed(hp.current_health, hp.max_health)
	if player.has_node("StaminaComponent"):
		var stam := player.get_node("StaminaComponent") as StaminaComponent
		stam.stamina_changed.connect(_on_stamina_changed)
		_on_stamina_changed(stam.current_stamina, stam.max_stamina)

func _on_health_changed(current: float, max_value: float) -> void:
	hp_bar.max_value = max_value
	hp_bar.value = current

func _on_stamina_changed(current: float, max_value: float) -> void:
	stamina_bar.max_value = max_value
	stamina_bar.value = current
