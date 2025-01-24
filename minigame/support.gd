class_name Support
extends SubViewportContainer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


static func spawn_support(game: String) -> Support:
	var support = load("res://minigame/support.tscn").instantiate()
	print("res://minigame/"+game+".tscn")
	var minigame: PackedScene = load("res://minigame/"+game+".tscn")
	var minigame_instance = minigame.instantiate()
	
	support.add_child(minigame_instance)
	return support
	
	
	
