extends Interactable

var sounds = [
	load("res://sounds/cannette1.mp3"),
	load("res://sounds/cannette2.mp3"),
	load("res://sounds/cannette3.mp3"),
	load("res://sounds/cannette4.mp3")
]
var model = [
	load('res://model/cannette_red.tres'),
	load('res://model/cannette_green.tres'),
	load('res://model/cannette_yellow.tres'),
	load('res://model/cannette_purple.tres')
]

var collide_bodies = []
var sound = false

func interact(player: Player) -> void:
	Task.complete_task("PickupCans")
	if randf() < 0.9:
		Sound.play_sound_from_name("swoosh.mp3")
	else:
		Sound.play_sound_from_name("drinkfull.mp3")
	queue_free()

func is_interactable(player):
	return Task.is_task_left("PickupCans")

	
func _ready() -> void:
	$Canette.mesh = model.pick_random()
	

func _on_body_entered(body: Node) -> void:
	if not(body in collide_bodies) and sound:
		Sound.play_sound_from_stream(sounds[randi() % len(sounds)])
		collide_bodies.append(body)

func _on_timer_timeout() -> void:
	sound = true
