extends Control

var tasks =[]
var task_labels = []
var base_position = Vector2(15, 15)
var mini_position = Vector2(-250, 15)
var speed = 10
var crosses = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var header = TaskData.new()
	header.name = "Complete all tasks"
	add_task(header)
	for task: TaskData in Task.schedule[Task.current_day].task:
		add_task(task)
	Task.update_task.connect(_on_task_update)


func add_task(task_data: TaskData) -> void:
	var task_name = task_data.name
	var task_label := Label.new()  
	task_label.text = task_name
	if task_data.amount > 1: task_label.text += "  " + str(task_data.n) + "/" + str(task_data.amount)
	task_label.modulate = Color.BLACK
	$VBoxContainer.add_child(task_label)  
	
	tasks.append(task_label)
	
	task_labels.append(task_label)

func cross_task(task):
	var i = 0
	for child in $VBoxContainer.get_children():
		if child.text.begins_with(task.name):
			var cross = load("res://game/cross.tscn").instantiate()
			crosses.append(cross)
			var increment = Vector2(0, 38)
			cross.position = Vector2(2, 16) + increment * i
			cross.target = cross.position
			var tween = create_tween()
			Sound.play_sound_from_name("pen.mp3", 0.1, 10.0)
			tween.tween_property(cross, "target", Vector2(154, 16) + increment * i, 2)
			if task.amount > 1:
				child.text = task.name + "  " + str(task.n) + "/" + str(task.amount)
		i += 1

func _on_task_update(task: TaskData):
	if task.n == task.amount:
		cross_task(task)
	else:
		for child in $VBoxContainer.get_children():
			if child.text.begins_with(task.name):
				child.text = task.name + "  " + str(task.n) + "/" + str(task.amount)

func _process(delta: float) -> void:
	var target = base_position
	if get_parent().get_node("Player").in_minigame or get_parent().get_node("Player").fall:
		target = mini_position
	position = lerp(position, target, speed * delta)
	queue_redraw()

func _input(event):
	if event is InputEventMouseMotion:
		position += -event.relative * get_parent().get_node("Player").mouse_sensitivity

func _draw() -> void:
	for cross in crosses:
		draw_line(cross.position, cross.target, Color.BLACK, 1.5)
