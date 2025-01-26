extends Control

signal finished

var letter_floor = 200
@onready var back = $Front/Back
@onready var closed = $Front/Closed
var fallen = false
var wait_for_bye = false

func _ready() -> void:
	if Task.schedule[Task.current_day].letter:
		self.scale = Vector2.ONE * 0.25
		self.position.y = -200
		self.rotation += randf() - 0.5
		back.visible = false
		closed.visible = true
		$Front.visible = true
		fall_down()
	else:
		queue_free()

func fall_down():
	var tween = create_tween()
	tween.tween_property(self, "position:y", letter_floor, 2).set_trans(Tween.TRANS_BOUNCE)
	var tween2 = create_tween()
	tween2.tween_interval(1)
	tween2.tween_callback(func(): Sound.play_sound_from_name("pop.wav"))
	tween.chain().tween_callback(func(): fallen = true)

func open():
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2.ONE, 1).set_ease(Tween.EASE_OUT)
	tween.set_parallel().tween_property(self, "rotation", 0, 1).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "position", Vector2(322, 483), 1).set_ease(Tween.EASE_OUT)
	tween.chain().tween_callback(func(): back.visible = true; closed.visible = false; $Paper.visible = true; Sound.play_sound_from_name("tearenv.mp3"))
	tween.tween_property($Paper, "position", Vector2(-269, -485), 1).set_trans(Tween.TRANS_ELASTIC)
	tween.tween_callback(func(): wait_for_bye = true)

func bye():
	Sound.play_sound_from_name("swoosh.mp3")
	var tween = create_tween()
	tween.tween_property(self, "position", Vector2(322, 1000), 1).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_ELASTIC)
	tween.tween_callback(func(): self.visible = false; finished.emit())

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("left_click") and fallen:
		Sound.play_sound_from_name("swoosh.mp3")
		open()
		fallen = false
	if Input.is_action_just_pressed("left_click") and wait_for_bye:
		bye()
		wait_for_bye = false
