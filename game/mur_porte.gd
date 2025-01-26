extends StaticBody3D

@onready var porte = $Porte

var is_open = false
var transition = false

func _process(delta: float) -> void:
	var player = Task.player
	var distance = position.distance_squared_to(player.position)
	if !transition:
		if distance < 100.0:
			if !is_open:
				open()
		else:
			if is_open:
				close()

func open():
	transition = true
	var tween = create_tween()
	tween.tween_callback(creaking)
	tween.tween_property($Porte, "rotation:y", deg_to_rad(120), 1)
	tween.tween_callback(func(): is_open = true; transition = false)

func close():
	transition = true
	var tween = create_tween()
	tween.tween_property($Porte, "rotation:y", 0, 1)
	tween.tween_callback(func(): is_open = false; transition = false)

func creaking():
	if (randf()<0.1):
		Sound.play_sound_from_name("creaking.mp3")
	else:
		Sound.play_sound_from_name("door_swoosh.mp3",0.3,-10)
