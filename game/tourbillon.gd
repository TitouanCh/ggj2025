extends MeshInstance3D



func _process(delta: float) -> void:
	self.rotation.y += delta * 0.02 
