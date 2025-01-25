class_name MachineSoda
extends Interactable

var true_name_task = "PlayMoney"
var used = false

func interact(player: Player):
	print("Machine Soda")
	player.start_minigame("money").finished.connect(close)
	Sound.play_sound_from_name("metal_door.mp3")
	used = true
	open()

func is_interactable(player):
	return Task.is_task_left(true_name_task) and !used

func open():
	var tween = create_tween()
	tween.tween_property($DoorJoint, "rotation:y", deg_to_rad(-102), 1).set_ease(Tween.EASE_IN_OUT)

func close():
	var tween = create_tween()
	tween.tween_property($DoorJoint, "rotation:y", 0, 1.2).set_ease(Tween.EASE_IN_OUT)
