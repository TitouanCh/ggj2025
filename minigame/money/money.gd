extends Minigame

@export var font: Font
var coin_scene = preload("res://minigame/money/coin.tscn")
var money_made = 0

func _process(delta: float) -> void:
	queue_redraw()

func _on_timer_timeout() -> void:
	spawn_coin(Vector2(dimensions.x * randf(), 0))

func spawn_coin(vec: Vector2):
	var instance = coin_scene.instantiate()
	instance.position = vec
	add_child(instance)

func _draw() -> void:
	draw_string(font, Vector2(32, 32), str(money_made))
	#draw_rect(Rect2(0, 0, 720, 405), Color.RED)

func _on_timer_2_timeout() -> void:
	finished.emit()
