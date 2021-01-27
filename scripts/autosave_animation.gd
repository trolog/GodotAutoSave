extends AnimatedSprite

func _ready() -> void:
	playing = true

func _on_autosave_animation_animation_finished() -> void:
	queue_free()
	pass # Replace with function body.
