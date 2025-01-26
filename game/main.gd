class_name Main
extends Node3D

@export var level_data: LevelData = null
var todo_list

func _ready() -> void:
	Task.set_main(self)
	if level_data:
		level_data.spawn(self)
		todo_list = preload("res://game/todo.tscn").instantiate()
		add_child(todo_list)  
		todo_list.visible = true  
