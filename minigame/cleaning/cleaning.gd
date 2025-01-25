extends Minigame
var a = []
var cursor_texture : Texture
var cursor_hotspot
@onready var sponge = $Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	for i in range(10):
		var coord = Vector2((dimensions.x-20) * randf(), (dimensions.y-20) * randf())
		var tache = Tache.spawn(coord)
		tache.die.connect(_on_tache_die)
		a.append(tache)
		add_child(tache)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	sponge.position = get_local_mouse_position()
	
	if a.is_empty():
		finished.emit()
		queue_free()
	
	queue_redraw()
	

func _on_tache_die(tache):
	a.erase(tache)

func _draw() -> void:
	draw_rect(Rect2(0, 0, $Timer.time_left/$Timer.wait_time * dimensions.x, 10), Color.RED)
