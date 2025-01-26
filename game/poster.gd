extends Interactable
var model = [
	load("res://model/poster_eau.tres"),
	load("res://model/poster_eau2.tres"),
	load("res://model/poster_sport.tres"),
	load("res://model/poster.tres")
]
var isRipped = false
var ripped = load("res://model/poster_ripped.tres")

func is_interactable(player):
	return Task.is_task_left("RipPoster") and not isRipped

func interact(player: Player) -> void:
	Task.complete_task("RipPoster")
	Sound.play_sound_from_name("ripping.mp3")
	$MeshInstance3D.mesh = ripped
	isRipped = true
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$MeshInstance3D.mesh = model.pick_random()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
