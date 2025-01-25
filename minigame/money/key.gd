class_name Key
extends Node2D

signal unlock

static var key_sprites = []
static var grabbed_key = null
var grabbed = false
var target = Vector2.ZERO
var eps = 40
var speed = 10
var good = false
var bye = false
var Tdelta = randf()
var serrure = null

func _ready() -> void:
	randomize()
	var i = randi() % len(key_sprites)
	$Sprite2D.texture = key_sprites[i]["texture"]
	$Sprite2D.flip_h = key_sprites[i].flip_h
	key_sprites.remove_at(i)

func _process(delta: float) -> void:
	if Input.is_action_pressed("left_click"):
		if get_local_mouse_position().length() < eps and grabbed_key == null:
			grabbed = true
			grabbed_key = self
			Sound.play_sound_from_name("keys.mp3")
	else:
		if grabbed:
			grabbed = false
			Sound.play_sound_from_name("keys.mp3", -0.3)
		grabbed_key = null
	if grabbed and !bye:
		target = get_global_mouse_position()
	
	if position.distance_to(serrure.position) < eps and good:
		unlock.emit()
		Sound.play_sound_from_name("unlock.mp3", 0.1, 5.0)
	
	$Sprite2D.offset.y = cos(Tdelta * 10) * 5
	position = lerp(position, target, delta * speed)
	Tdelta += delta

static func restore_sprites():
	key_sprites = [
		{
			"texture": preload("res://sprites/money/clef1.png"),
			"flip_h": false
		},
		{
			"texture": preload("res://sprites/money/clef2.png"),
			"flip_h": false
		},
		{
			"texture": preload("res://sprites/money/clef3.png"),
			"flip_h": true
		},
		{
			"texture": preload("res://sprites/money/clef4.png"),
			"flip_h": false
		}
	]
