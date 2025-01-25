extends Node2D
var a = []


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in range(20):
		var tache = Tache.spawn()
		a.append(tache)
		add_child(tache)
	
# Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
