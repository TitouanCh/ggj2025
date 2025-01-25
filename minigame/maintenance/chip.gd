extends Node2D
class_name Chip

var sprite : Sprite2D
var side: String
var color: Color
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'dqelta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
static func spawn(vec: Vector2) -> Chip:
	var chip = load("res://minigame/maintenance/chip.tscn").instantiate()
	chip.position = vec
	return chip

func set_sprite(textu: Texture) -> void :
	sprite = Sprite2D.new()
	sprite.texture = textu
	sprite.scale=Vector2(0.5,0.5)
	add_child(sprite)	
	
func set_side(sid: String) -> void:
	self.side = sid
func set_color(col: Color) -> void:
	self.color = col
