extends StaticBody3D

var model = [
	load("res://model/poster_eau.tres"),
	load("res://model/poster_eau_2.png"),
	load("res://model/poster_sport.tres"),
	load("res://model/poster.tres")
]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$MeshInstance3D.mesh = model.pick_random()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
