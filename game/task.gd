extends Node

signal update_task(task)

var schedule: Array[Day] = [
	#load("res://days/day5.tres"), # Test
	load("res://days/day1.tres"),
	load("res://days/day2.tres"),
	null,
	load("res://days/day4.tres"),
	load("res://days/day5.tres"),
	load("res://days/day6.tres")
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
	if current_day == 2: current_day += 1
	if current_day >= len(schedule):
		current_day = 0
	main.queue_free()
	var instance = main_scene.instantiate()
	viewport.add_child(instance)

func get_machine_true_name_task() -> String:
	var task_that_need_machine = []
	var all_machine_task = []
	for task in schedule[current_day].task:
		if task.true_name.begins_with("Play"):
			if task.n_machines < task.amount:
				task_that_need_machine.append(task)
			all_machine_task.append(task)
	
	if len(task_that_need_machine) + len(all_machine_task) == 0: return "PlayNone"
	
	var task
	if len(task_that_need_machine) > 0:
		task = task_that_need_machine.pick_random()
	else: task = all_machine_task.pick_random()
	if task:
		task.n_machines += 1
		return task.true_name
	else:
		return "PlayNone"
