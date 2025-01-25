class_name MachineSoda
extends Interactable

func interact(player: Player):
	print("Machine Soda")
	player.start_minigame("money")
	open()

func open():
	var tween = create_tween()
	tween.tween_method($DoorJoint.rotate_y, 0, deg_to_rad(-90), 1).set_trans(Tween.TRANS_BOUNCE)
