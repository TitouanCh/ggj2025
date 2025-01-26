extends Minigame

func _ready() -> void:
	$Node2D.position = dimensions/2

func _process(delta: float) -> void:
	queue_redraw()

func _on_timer_timeout() -> void:
	finished.emit()

func _draw() -> void:
	draw_rect(Rect2(0, 0, $Timer.time_left/$Timer.wait_time * dimensions.x, 10), Color.RED)
