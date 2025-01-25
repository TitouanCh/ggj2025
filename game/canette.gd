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
	queue_free()
	
func _ready() -> void:
	$Canette.mesh = model.pick_random()
	
func _on_body_entered(body: Node) -> void:
	if not(body in collide_bodies) and sound:
		Sound.play_sound_from_stream(sounds[randi() % len(sounds)])
		collide_bodies.append(body)

func _on_timer_timeout() -> void:
	sound = true
