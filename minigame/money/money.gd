extends Minigame

@export var font: Font
var coin_scene = preload("res://minigame/money/coin.tscn")
var key_scene = preload("res://minigame/money/key.tscn")
var money_made = 0
var keys = []
var money_spawn = Vector2(dimensions.x * randf(), 0)
var hand_texture = [load("res://sprites/open_hand.png"), load("res://sprites/closed_fist.png")]

func _ready() -> void:
	Key.restore_sprites()
	spawn_3_keys()

func _process(delta: float) -> void:
	$Hand.position = get_global_mouse_position()
	if Input.is_action_pressed("left_click") and !$Bucket.visible:
		$Hand.texture = hand_texture[1]
	else:
		$Hand.texture = hand_texture[0]
	queue_redraw()

func _on_timer_timeout() -> void:
	spawn_coin(money_spawn)
	$Timer.wait_time = randf() * 0.2

func spawn_3_keys():
	var j = randi() % 3
	for i in range(3):
		var instance = key_scene.instantiate()
		add_child(instance)
		instance.position = Vector2(550 + dimensions.x, 120 + (i * 100))
		instance.target = Vector2(500, 80 + (i * 100))
		instance.serrure = $Serrure
		instance.unlock.connect(_on_unlock)
		keys.append(instance)
		if i == j:
			instance.good = true

func bye_keys():
	var i = 0
	for key in keys:
		key.bye = true
		key.target = Vector2(550 + dimensions.x, 120 + (i * 100))
		i += 1
	var tween = create_tween()
	tween.tween_property($Serrure, "position", Vector2(-124, 198), 2).set_trans(Tween.TRANS_ELASTIC)
	tween.tween_callback(money_shower)

func _on_unlock():
	bye_keys()
	move_money_spawn()

func money_shower():
	$Bucket.visible = true
	$Timer.start()
	$Timer2.start()

func spawn_coin(vec: Vector2):
	var instance = coin_scene.instantiate()
	instance.position = vec
	add_child(instance)

func _draw() -> void:
	draw_string(font, Vector2(32, 32), str(money_made))
	#draw_rect(Rect2(Vector2.ZERO, dimensions), Color.BLUE)
	#draw_circle(get_local_mouse_position(), 8.0, Color.RED)
	if $Bucket.visible: draw_rect(Rect2(0, 0, $Timer2.time_left/$Timer2.wait_time * dimensions.x, 10), Color.RED)

func _on_timer_2_timeout() -> void:
	finished.emit()

func move_money_spawn():
	var tween = create_tween()
	tween.tween_property(self, "money_spawn", Vector2(dimensions.x * randf(), 0), randf() * 0.5)
	tween.set_ease(Tween.EASE_IN_OUT)
	if randf() > 0.2:
		tween.set_trans(Tween.TRANS_BACK)
	elif randf() > 0.5:
		tween.set_trans(Tween.TRANS_BACK)
	elif randf() > 0.8:
		tween.set_trans(Tween.TRANS_BACK)
	else:
		tween.set_trans(Tween.TRANS_LINEAR)
	tween.tween_callback(move_money_spawn)
