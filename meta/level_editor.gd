extends Node2D

var data: LevelData = LevelData.new()

var wall_color = {
	"Normal": Color.GREEN,
	"Hublot": Color.BLUE,
	"Door": Color.AQUA,
	"DoorFermee": Color.DARK_BLUE,
	"Gris": Color.GRAY,
	"HublotGris": Color.DIM_GRAY,
	"DoorGris": Color.DARK_GRAY,
	"DoorFermeeGris": Color.LIGHT_BLUE,
	"Vert": Color.DARK_GREEN,
	"HublotVert": Color.LAWN_GREEN,
	"DoorVert": Color.AQUAMARINE,
	"DoorFermeeVert": Color.CHARTREUSE,
	"DoorBleuVert": Color.DARK_VIOLET,
	"MurRideau": Color.HOT_PINK,
	"PosterVert": Color.GOLD,
	"PosterGris": Color.GREEN_YELLOW,
	"PosterViolet": Color.INDIGO
}


var fr_color = {
	"Base": Color(144, 144, 144, 0.85),
	"Gris": Color(244, 0, 0, 0.85),
	"Vert": Color(0, 244, 0, 0.85),
}


var meta_color = {
	"PlayerPosition": Color.RED,
	"Machine": Color.PURPLE,
	"Pouf": Color.YELLOW_GREEN,
	"Table": Color.YELLOW,
	"TablePoufCannette": Color.BLUE_VIOLET,
	"Pyramide": Color.ORANGE,
	"Desastre": Color.PALE_VIOLET_RED,
	"Cannette1": Color.DARK_RED,
	"Cannette2": Color.DARK_BLUE,
	"Cannette3": Color.DARK_CYAN,
	"Pillier_violet": Color.LIGHT_STEEL_BLUE,
	"Pillier_vert": Color.TEAL,
	"Pillier_gris": Color.SIENNA,
	"Plante": Color.CHARTREUSE
}

var current_base = 0
var current_type = 0

var current = null
var snap = 32
var small_snap = 4

var classes = {
	"wall": WallData,
	"fr": FRData,
	"meta": MetaData
}

var types = {
	"wall": ["Normal", "Hublot", "Door", "DoorFermee", "Gris", "HublotGris", "DoorGris", "DoorFermeeGris", "Vert", "HublotVert", "DoorVert", "DoorFermeeVert", "DoorBleuVert", "MurRideau",
	"PosterVert","PosterGris","PosterViolet"],
	"fr": ["Base", "Gris", "Vert"],
	"meta": ["PlayerPosition", "Machine", "Pouf", "Table", "TablePoufCannette", "Pyramide", "Desastre", "Cannette1", "Cannette2", "Cannette3","Pillier_vert","Pillier_gris","Pillier_violet"]
}

func get_mouse_position():
	var mouse_position = get_global_mouse_position()
	if Input.is_action_pressed("snap"): mouse_position = mouse_position.snappedf(snap)
	if Input.is_action_pressed("small_snap"): mouse_position = mouse_position.snappedf(small_snap)
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
	
	if Input.is_action_pressed("erase"):
		for wall in data.wall:
			if wall.position.distance_to(get_mouse_position()) < 32.0:
				data.wall.erase(wall)
		for fr in data.fr:
			if fr.position.distance_to(get_mouse_position()) < 32.0:
				data.fr.erase(fr)
		for meta in data.meta:
			if meta.position.distance_to(get_mouse_position()) < 32.0:
				data.meta.erase(meta)
	
	if Input.is_action_pressed("erase_only_meta"):
		for meta in data.meta:
			if meta.position.distance_to(get_mouse_position()) < 32.0:
				data.meta.erase(meta)
	
	if Input.is_action_pressed("left_click"):
		match get_current_base():
			"wall":
				current.to_position = current.position + (get_mouse_position() - current.position).normalized() * 32
			"meta":
				current.rotation = ((get_mouse_position() - current.position).normalized() * 32).angle()

	if Input.is_action_just_released("left_click"):
		data.get(get_current_base()).append(current)
	
	$Label.text = get_current_base() + " : " + get_current_type()
	
	queue_redraw()

func _draw() -> void:
	if Input.is_action_pressed("erase"): draw_circle(get_mouse_position(), 32.0, Color.BLUE)
	if Input.is_action_pressed("erase_only_meta"): draw_circle(get_mouse_position(), 32.0, Color.MEDIUM_SEA_GREEN)
	else: draw_circle(get_mouse_position(), 2.0, Color.RED)
	
	var arr = data.wall + data.fr + data.meta
	if Input.is_action_pressed("left_click"): arr += [current]
	for obj in arr:
		if obj is WallData:
			draw_line(obj.position, obj.to_position, wall_color[obj.type], 3)
		if obj is FRData:
			draw_rect(Rect2(obj.position, Vector2.ONE * snap), fr_color[obj.type])
		if obj is MetaData:
			draw_circle(obj.position, 2.5, meta_color[obj.type])
			draw_line(obj.position, obj.position + (Vector2.ONE.rotated(obj.rotation - PI/4) * 8.0), meta_color[obj.type], 1)
