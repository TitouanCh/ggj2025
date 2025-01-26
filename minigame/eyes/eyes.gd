extends Minigame

var closed = load("res://sprites/weird/SPRITE_oeilferme.png")
var open = load("res://sprites/weird/SPRITE_oeilouvert.png")
@onready var sprite = $Sprite2D
@onready var base_sprite_scale = 0.5
var Tdelta = 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sprite.position = dimensions/2
	
	var clin = create_tween().set_loops()
	
	clin.tween_callback(func(): $Sprite2D.texture = closed; sprite.scale = Vector2.ONE * 1.2 * base_sprite_scale; Sound.play_sound_from_name("eye.mp3", 1.0))
	clin.tween_interval(0.3)
	clin.tween_callback(func(): $Sprite2D.texture = open; sprite.scale = Vector2.ONE * 1.2 * base_sprite_scale)
	clin.tween_interval(1.1)
	

func _process(delta: float) -> void:
	sprite.scale = lerp(sprite.scale, Vector2.ONE * base_sprite_scale, delta * 10)
	sprite.position.y = dimensions.y/2 + cos(Tdelta * 4.0) * 40
	sprite.position.x = dimensions.x/2 + sin(Tdelta * 4.0) * 40
	Tdelta += delta
	
	queue_redraw()

func _draw() -> void:
	draw_rect(Rect2(0, 0, $Timer.time_left/$Timer.wait_time * dimensions.x, 10), Color.RED)


func _on_timer_timeout() -> void:
	finished.emit()
