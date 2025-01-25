extends Node

signal update_task(task)

var schedule: Array[Day] = [
	load("res://days/day1.tres")
]

var current_day = 0
var main: Main

func set_main(p_main):
	main = p_main
	main.level_data = schedule[current_day].map

func complete_task(task_true_name):
	for task in schedule[current_day].task:
		if task.true_name == task_true_name and task.n < task.amount:
			task.n += 1
			update_task.emit(task)
