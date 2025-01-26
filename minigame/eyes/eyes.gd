extends Minigame


@onready var sprite_base = $Sprite2D
var closed = load("res://sprites/weird_eyes/eyes_open.PNG")
var open = load("res://sprites/weird_eyes/closed_eyes.jpg")
@onready var base_sprite_scale = 0.8
var Tdelta = 0.0
var nb_oeil = 10
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
		clin.tween_callback(func(): sprite.texture = closed; sprite.scale = Vector2.ONE * 1.2 * base_sprite_scale; Sound.play_sound_from_name("eye.mp3", 1.0))
		clin.tween_interval(0.3)
		clin.tween_callback(func(): sprite.texture = open; sprite.scale = Vector2.ONE * 1.2 * base_sprite_scale)
		clin.tween_interval(1.1)
		circles.append(100.0 * randf() + 19)
		offset.append(randf() * 2 * PI)
		oeils.append(sprite)
		sprite.visible = false
	
	Sound.play_sound_from_name("weird_sounds.mp3")

func _process(delta: float) -> void:
	var i = 0
	for sprite in oeils:
		if i < (1.0 - $Timer.time_left/$Timer.wait_time) * nb_oeil:
			sprite.visible = true
			sprite.scale = lerp(sprite.scale, Vector2.ONE * base_sprite_scale, delta * 10)
			sprite.position.y = dimensions.y/2 + cos(Tdelta * 4.0 + offset[i]) * circles[i]
			sprite.position.x = dimensions.x/2 + sin(Tdelta * 4.0 + offset[i]) * circles[i]
		i += 1
	
	Tdelta += delta * min(max(Tdelta, 0.1), 0.5)
	
	queue_redraw()

func _draw() -> void:
	draw_rect(Rect2(0, 0, $Timer.time_left/$Timer.wait_time * dimensions.x, 10), Color.RED)


func _on_timer_timeout() -> void:
	finished.emit()
