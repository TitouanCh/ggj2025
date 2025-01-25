extends TextureRect

var target1 = Vector2(408, 243)
var target2 = Vector2(408, 400)
var interact = false
var speed = 10

func _process(delta: float) -> void:
	if interact:
		position = lerp(position, target1, speed * delta)
	else:
		position = lerp(position, target2, speed * delta)
