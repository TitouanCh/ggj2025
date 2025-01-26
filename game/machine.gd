class_name MachineSoda
extends Interactable

var true_name_task = "PlayMoney"
var used = false
var model = {
	'green':[
		load("res://model/machine/machine_base_green.tres"),
		load("res://model/machine/machine_door_green.tres"),
		load("res://model/machine/machine_logo_green.tres")
	],
	'yellow':[
		load("res://model/machine/machine_base_yellow.tres"),
		load("res://model/machine/machine_door_yellow.tres"),
		load("res://model/machine/machine_logo_yellow.tres")
	],
	'red':[
		load("res://model/machine/machine_base_red.tres"),
		load("res://model/machine/machine_door_red.tres"),
		load("res://model/machine/machine_logo_red.tres")
	],
	'purple':[
		load("res://model/machine/machine_base_purple.tres"),
		load("res://model/machine/machine_door_purple.tres"),
		load("res://model/machine/machine_logo_purple.tres")
	]
}

var model_keys=["green","yellow","red","purple"]

func interact(player: Player):
	print("Machine Soda")
	player.start_minigame(true_name_task.replace("Play", "").to_lower()).finished.connect(close)
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

func _ready() -> void:
	randomize()
	var color = model_keys.pick_random()
	$AssetMachineV2.mesh = model[color][0]
	$DoorJoint/AssetMachinePorteV1.mesh = model[color][1]
	$DoorJoint/AssetMachinePorteV1/logo.mesh = model[color][2]
	
	
	
