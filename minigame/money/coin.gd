extends RigidBody2D


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
