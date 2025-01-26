extends Minigame

var lip_scene = preload("res://minigame/kiss/lips.tscn")
@onready var max_wait_time = $Timer.wait_time

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("left_click"):
		var instance = lip_scene.instantiate()
		add_child(instance)
		instance.position = get_local_mouse_position()
		instance.rotation = randf() * 2 * PI
		
		Sound.play_sound_from_name("ching.mp3", 0.5)
		var a = $Timer.time_left 
		$Timer.stop()
		$Timer.wait_time = max(a - 1, 0.01)
		$Timer.start()
	
	queue_redraw()


func _draw() -> void:
	draw_rect(Rect2(0, 0, $Timer.time_left/max_wait_time * dimensions.x, 10), Color.RED)

func _on_timer_timeout() -> void:
	finished.emit()
