extends State

func enter(_prev: String, _data: Dictionary = {}) -> void:
	player.velocity = Vector2.ZERO
	player.animations.play("dead")
