extends Minigame

var closed = load("res://sprites/weird_eyes/closed_eyes.jpg")
var open = load("res://sprites/weird_eyes/eyes_open.PNG")
@onready var sprite_base = $Sprite2D
@onready var base_sprite_scale = 0.5
var Tdelta = 0.0
var nb_oeil = 100
var oeils = []
var circles = []
var offset = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in range(nb_oeil):
		var sprite = sprite_base.duplicate()
		add_child(sprite)
		sprite.position = dimensions/2
		var clin = create_tween().set_loops()
		clin.tween_callback(func(): $Sprite2D.texture = closed; sprite.scale = Vector2.ONE * 1.2 * base_sprite_scale; Sound.play_sound_from_name("eye.mp3", 1.0))
		clin.tween_interval(0.3)
		clin.tween_callback(func(): $Sprite2D.texture = open; sprite.scale = Vector2.ONE * 1.2 * base_sprite_scale)
		clin.tween_interval(1.1)
		circles.append(100.0 * randf() + 19)
		offset.append(randf())
		oeils.append(sprite)

func _process(delta: float) -> void:
	var i = 0
	for sprite in oeils:
		sprite.scale = lerp(sprite.scale, Vector2.ONE * base_sprite_scale, delta * 10)
		sprite.position.y = dimensions.y/2 + cos(Tdelta * 4.0 + offset[i]) * circles[i]
		sprite.position.x = dimensions.x/2 + sin(Tdelta * 4.0 + offset[i]) * circles[i]
		i += 1
	Tdelta += delta
	
	queue_redraw()

func _draw() -> void:
	draw_rect(Rect2(0, 0, $Timer.time_left/$Timer.wait_time * dimensions.x, 10), Color.RED)


func _on_timer_timeout() -> void:
	finished.emit()
