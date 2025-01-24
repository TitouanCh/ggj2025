extends Node

func _ready() -> void:
	$SubViewport.set_texture_filter(CanvasItem.TEXTURE_FILTER_NEAREST)
