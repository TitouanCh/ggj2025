extends Control

var tasks =[]
var task_labels = []
var base_position = Vector2(15, 15)
var mini_position = Vector2(-250, 15)
var speed = 10
var crosses = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_task("Complete all tasks")
	add_task("Pick up 5 cans")
	add_task("Jump")
	add_task("Jump")
	add_task("Jump")
	
	cross_task("Complete all tasks")
	cross_task("Pick up 5 cans")
	
	
func add_task(task_name: String) -> void:
	var task_label := Label.new()  
	task_label.text = task_name
	task_label.modulate = Color.BLACK
	$VBoxContainer.add_child(task_label)  
	
	tasks.append(task_label)
	
	task_labels.append(task_label)

func cross_task(task_name):
	var i = 0
	for child in $VBoxContainer.get_children():
		if child.text == task_name:
			var cross = load("res://game/cross.tscn").instantiate()
			crosses.append(cross)
			var increment = Vector2(0, 36)
			cross.position = Vector2(2, 16) + increment * i
			cross.target = cross.position
			var tween = create_tween()
			tween.tween_property(cross, "target", child.position + Vector2(154, randf() * 16) + increment * i, 2)
		i += 1


func _process(delta: float) -> void:
	var target = base_position
	if get_parent().get_node("Player").in_minigame:
		target = mini_position
	position = lerp(position, target, speed * delta)
	queue_redraw()

func _input(event):
	if event is InputEventMouseMotion:
		position += -event.relative * get_parent().get_node("Player").mouse_sensitivity

func _draw() -> void:
	for cross in crosses:
		draw_line(cross.position, cross.target, Color.BLACK, 1.5)
