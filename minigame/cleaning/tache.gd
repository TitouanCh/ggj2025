extends Node2D
class_name Tache

var x: int
var y: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var center_position = Vector2(x, y)
	print($Sprite2D.texture.get_size())
	position = center_position - $Sprite2D.texture.get_size() / 2

	# Replace with function body.
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
static func spawn() -> Tache:
	var tache = load("res://minigame/cleaning/tache.tscn").instantiate()
	
	tache.x = randi_range(0,941)
	tache.y = randi_range(0,541)
	print("Spawned tache at: ")
	print(tache.x)
	print(tache.y)
	
	return tache
	
