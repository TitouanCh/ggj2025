extends Node2D
class_name Tache

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
	sprite.scale=Vector2(0.8,0.8)
	add_child(sprite)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("left_click"):
		if is_mouse_over():
			handle_click()

func is_mouse_over() -> bool:
	var cursor_position = get_parent().sponge.position
	var sprite_rect = Rect2(position, sprite.texture.get_size())
	return sprite_rect.has_point(cursor_position)
	
	
func handle_click() -> void:
	queue_free()
	die.emit(self)

	
static func spawn(vec:Vector2) -> Tache:
	var tache = load("res://minigame/cleaning/tache.tscn").instantiate()
	
	tache.position = vec
	print("Spawned tache at: ")
	print(tache.position)
	
	return tache
	
