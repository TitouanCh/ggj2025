extends Control

@onready var label = $RichTextLabel
signal finished
var go = false

func _ready() -> void:
	label.visible_characters = 0
	#come_over()

func come_over():
	var tween = create_tween()
	tween.tween_interval(2)
	tween.tween_property(self, "position:x", 365, 2).set_trans(Tween.TRANS_ELASTIC)
	tween.tween_callback(show_text)

func bye():
	var tween = create_tween()
	tween.tween_property(self, "position:x", 800, 2).set_ease(Tween.EASE_IN)
	tween.tween_callback(func(): finished.emit())

func show_text():
	label.text = "[wave amp=16.0 freq=5.0 connected=1]" + Task.schedule[Task.current_day].dialog
	label.visible_characters = 0
	var tween = create_tween()
	tween.tween_property(label, "visible_ratio", 1.0, 5)
	
	var blah_tween = create_tween().set_loops()
	blah_tween.tween_interval(0.5)
	blah_tween.tween_callback(play_random_blah)
	
	tween.tween_callback(func(): blah_tween.kill())
	tween.tween_interval(5)
	tween.tween_callback(bye)

func play_random_blah():
	var i = randi() % 4 + 1
	Sound.play_sound_from_name("blah" + str(i) + ".mp3")
