extends Node2D
class_name Tache

var x: int
var y: int
var is_clicked : bool = false
var epsilon : float = 30.0
var textures = []
var sprite
signal die(this)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	textures.append(load("res://texture/minigame/stains/stain_1.png"))
	textures.append(load("res://texture/minigame/stains/stain_2.png"))
	textures.append(load("res://texture/minigame/stains/stain_3.png"))
	textures.append(load("res://texture/minigame/stains/stain_4.png"))
	sprite = Sprite2D.new()
	sprite.texture = textures.pick_random()
	add_child(sprite)
	var center_position = Vector2(x, y)
	position = center_position - sprite.texture.get_size() / 2


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("left_click"):
		if is_mouse_over():
			handle_click()

func is_mouse_over() -> bool:
	var cursor_position = get_global_mouse_position()
	var sprite_rect = Rect2(position, sprite.texture.get_size())
	return sprite_rect.has_point(cursor_position)
		
		
	
func handle_click() -> void:
	is_clicked = true
	queue_free()
	die.emit(self)

	
static func spawn() -> Tache:
	var tache = load("res://minigame/cleaning/tache.tscn").instantiate()
	
	tache.x = randi_range(0,941)
	tache.y = randi_range(0,541)
	print("Spawned tache at: ")
	print(tache.x)
	print(tache.y)
	
	
	return tache
	
