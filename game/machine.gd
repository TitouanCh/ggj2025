class_name MachineSoda
extends Interactable

func interact(player: Player):
	print("Machine Soda")
	player.start_minigame("maintenance").finished.connect(close)
	Sound.play_sound_from_name("metal_door.mp3")
	open()

func open():
	var tween = create_tween()
	tween.tween_property($DoorJoint, "rotation:y", deg_to_rad(-102), 1).set_ease(Tween.EASE_IN_OUT)

func close():
	var tween = create_tween()
	tween.tween_property($DoorJoint, "rotation:y", 0, 1.2).set_ease(Tween.EASE_IN_OUT)
