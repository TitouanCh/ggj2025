extends Minigame
var a = []
var cursor_texture : Texture
var cursor_hotspot

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	cursor_texture = load('res://texture/minigame/sponge.png')
	cursor_hotspot = cursor_texture.get_size() / 2
	
	Input.set_custom_mouse_cursor(cursor_texture, Input.CURSOR_ARROW, cursor_hotspot)
	
	for i in range(10):
		var tache = Tache.spawn()
		tache.die.connect(_on_tache_die)
		a.append(tache)
		add_child(tache)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if a.is_empty():
		end.emit(self)
		queue_free()

func _on_tache_die(tache):
	a.erase(tache)
