extends Node

signal update_task(task)

var schedule: Array[Day] = [
	load("res://days/day1.tres"),
	
]

var current_day = 0
var viewport
var main: Main
var player: Player
var main_scene = load("res://game/main.tscn")

func set_main(p_main):
	main = p_main
	main.level_data = schedule[current_day].map
	viewport = main.get_parent()

func set_player(p_player):
	player = p_player
	player.faded_to_black.connect(_on_faded_to_black)

func complete_task(task_true_name):
	var i = 0
	for task in schedule[current_day].task:
		if task.true_name == task_true_name and task.n < task.amount:
			task.n += 1
			update_task.emit(task)
		if task.n == task.amount:
			i += 1
	
	if i == len(schedule[current_day].task):
		finished_all_tasks()

func is_task_left(task_true_name) -> bool:
	for task in schedule[current_day].task:
		if task.true_name == task_true_name and task.n < task.amount:
			return true
	return false

func finished_all_tasks():
	player.fade_to_black()

func _on_faded_to_black():
	current_day += 1
	main.queue_free()
	var instance = main_scene.instantiate()
	viewport.add_child(instance)
