extends Node2D


func _ready() -> void:
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2.ONE * 1.2, 0.2)
	tween.tween_property(self, "scale", Vector2.ONE * 0.0, 2.0).set_ease(Tween.EASE_IN)
