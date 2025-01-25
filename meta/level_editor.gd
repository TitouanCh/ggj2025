extends Node2D

var data: LevelData = LevelData.new()

var wall_color = {
	"Normal": Color.GREEN,
	"Hublot": Color.BLUE,
	"Door": Color.AQUA
}

var current_base = 0
var current_type = 0

var current = null
var snap = 32

var classes = {
	"wall": WallData,
	"fr": FRData,
	"meta": MetaData
}

var types = {
	"wall": ["Normal", "Hublot", "Door"],
	"fr": ["Base"],
	"meta": ["PlayerPosition"]
}

func get_mouse_position():
	var mouse_position = get_global_mouse_position()
	if Input.is_action_pressed("snap"): mouse_position = mouse_position.snappedf(snap)
	return mouse_position

func get_current_type():
	return types[types.keys()[current_base]][current_type]

func get_current_base():
	return types.keys()[current_base]

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("1"):
		current_base += 1
		current_type = 0
		if current_base == len(types.keys()): current_base = 0
	
	if Input.is_action_just_pressed("2"):
		current_type += 1
		if current_type == len(types[types.keys()[current_base]]): current_type = 0
	
	if Input.is_action_just_pressed("left_click"):
		current = classes[get_current_base()].new()
		current.type = get_current_type()
		current.position = get_mouse_position()
	
	if Input.is_action_just_pressed("save"):
		ResourceSaver.save(data, "res://data/level.tres")
		print("saved!")
	
	if Input.is_action_just_pressed("load"):
		data = load("res://data/level.tres")
		print("load!")

	elif Input.is_action_just_released("left_click"):
		match get_current_base():
			"wall":
				current.to_position = current.position + (get_mouse_position() - current.position).normalized() * 32
		
		data.get(get_current_base()).append(current)
	
	$Label.text = get_current_base() + " : " + get_current_type()
	
	queue_redraw()

func _draw() -> void:
	draw_circle(get_mouse_position(), 2.0, Color.RED)
	for wall in data.wall:
		draw_line(wall.position, wall.to_position, wall_color[wall.type], 3)
	for fr in data.fr:
		draw_rect(Rect2(fr.position, Vector2.ONE * snap), Color(144, 144, 144, 0.85))
	for meta in data.meta:
		draw_circle(meta.position, 1.5, Color.RED)
