class_name Support
extends SubViewportContainer

signal finished

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_minigame_finished():
	finished.emit()
	self.queue_free()

static func spawn_support(game: String) -> Support:
	var support = load("res://minigame/support.tscn").instantiate()
	print("res://minigame/" + game + "/" + game + ".tscn")
	var minigame: PackedScene = load("res://minigame/" + game + "/" + game + ".tscn")
	var minigame_instance = minigame.instantiate()
	minigame_instance.finished.connect(support._on_minigame_finished)
	support.add_child(minigame_instance)
	return support
