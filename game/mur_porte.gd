extends StaticBody3D

@onready var porte = $Porte

var is_open = false

func _process(delta: float) -> void:
	var player = Task.player
	var distance = position.distance_squared_to(player.position)
	if distance < 100.0:
		if !is_open:
			open()
	else:
		if is_open:
			close()

func open():
	var tween = create_tween()
	tween.tween_property($Porte, "rotation:y", deg_to_rad(120), 1)
	tween.tween_callback(func(): is_open = true)

func close():
	var tween = create_tween()
	tween.tween_property($Porte, "rotation:y", 0, 1)
	tween.tween_callback(func(): is_open = false)
