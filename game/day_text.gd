extends RichTextLabel


var speed = 4

func _process(delta: float) -> void:
	position = lerp(position, Vector2(-78, 18), delta * speed)
