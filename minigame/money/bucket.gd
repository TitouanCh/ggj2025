extends CharacterBody2D

const SPEED = 10

@onready var bucket = create_bucket(100, 90, 50)

func _ready() -> void:
	$CollisionPolygon2D.polygon = bucket
	pass

func _physics_process(delta: float) -> void:
	var direction := get_local_mouse_position()
	if visible: velocity = direction * SPEED
	#print(position)
	move_and_slide()
#
#func _draw() -> void:
	#draw_colored_polygon(bucket, Color.WHITE)

func create_bucket(tall, width, offset = 20) -> PackedVector2Array:
	var arr: PackedVector2Array = []
	arr.append(Vector2(width/2, 0)) 
	arr.append(Vector2(width/2, -tall)) 
	arr.append(Vector2(width/2 + offset, -tall + offset))
	arr.append(Vector2(width/2, offset))
	arr.append(Vector2(-width/2, offset))
	arr.append(Vector2(-width/2 - offset, -tall + offset))
	arr.append(Vector2(-width/2, -tall))
	arr.append(Vector2(-width/2, 0))
	return arr


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Coin:
		get_parent().money_made += 1
		Sound.play_sound_from_name("ching.mp3", 0.5)
		body.queue_free()
