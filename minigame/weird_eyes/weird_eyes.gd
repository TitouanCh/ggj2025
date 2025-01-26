extends Minigame

var closed = load("res://sprites/weird_eyes/closed_eyes.jpg")
var open = load("res://sprites/weird_eyes/eyes_open.PNG")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var tween = create_tween()

	tween.tween_callback(func(): $Sprite2D.texture = closed)
	tween.tween_interval(0.1)
	tween.tween_callback(func(): $Sprite2D.texture = open)
	
	tween.tween_callback(func(): $Sprite2D.visible = false)
	tween.tween_interval(0.1)
	tween.tween_callback(func(): $Sprite2D.visible = true)
	
	tween.parallel().tween_property($Sprite2D, "scale", Vector2.ONE * 3, 1).set_trans(Tween.TRANS_ELASTIC)
	
	tween.tween_callback(func(): $Sprite2D.texture = closed)
	tween.tween_interval(0.1)
	tween.tween_callback(func(): $Sprite2D.texture = open)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
