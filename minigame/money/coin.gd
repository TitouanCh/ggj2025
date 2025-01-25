extends RigidBody2D

static var textures = [
	preload("res://sprites/money/p1.png"),
	preload("res://sprites/money/p1c.png"),
	preload("res://sprites/money/p2.png"),
	preload("res://sprites/money/p5.png"),
	preload("res://sprites/money/p50.png")
]

func _ready() -> void:
	var i = randi() % len(textures)
	$Sprite2D.texture = textures[i]

func _process(delta: float) -> void:
	if position.y > get_parent().dimensions.y:
		queue_free()
	queue_redraw()
	#if linear_velocity.length() < 5.0:
		#visible = false

#func _draw() -> void:
	#draw_circle(Vector2.ZERO, 16, Color.WHITE)

func _on_timer_timeout() -> void:
	get_parent().money_made += 1
	queue_free()
