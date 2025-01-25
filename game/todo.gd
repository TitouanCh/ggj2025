extends Control

var tasks =[]
var task_labels = []
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_task("Complete all tasks")
	add_task("Pick up 5 cans")
	add_task("Jump")
	
func add_task(task_name: String) -> void:
	var task_label = Label.new()  
	task_label.text = task_name  
	$VBoxContainer.add_child(task_label)  
	
	tasks.append(task_label)
	
	task_labels.append(task_label)

func _process(delta: float) -> void:
	pass
