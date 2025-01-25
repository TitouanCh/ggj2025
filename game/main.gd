class_name Main
extends Node3D

@export var level_data: LevelData = null

func _ready() -> void:
	if level_data:
		level_data.spawn(self)
