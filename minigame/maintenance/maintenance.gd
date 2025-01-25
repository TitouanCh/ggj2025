extends Minigame
var textures = {}
var texture_keys =[]
var current_start : Chip = null  # The current point being connected
var connected_lines = []
var epsilon = 40.0
var hand_texture = [load("res://sprites/open_hand.png"), load("res://sprites/closed_fist.png")]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	textures["yellow"] = load("res://sprites/chip/puce_Y.png")
	textures["blue"] = load("res://sprites/chip/puce_B.png")
	textures["red"] = load("res://sprites/chip/puce_R.png")
	textures["pink"] = load("res://sprites/chip/puce_P.png")
	texture_keys = textures.keys()  # Get keys as a list
	spawn_Chip()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$Hand.position = get_global_mouse_position() + Vector2(0,20)
	if Input.is_action_pressed("left_click"):
		$Hand.texture = hand_texture[1]
	else:
		$Hand.texture = hand_texture[0]
	if len(connected_lines) == 4:
		finished.emit()
		queue_free()
	queue_redraw()
	
func spawn_Chip() ->void:
	texture_keys.shuffle()
	for i in range(4):
		var chip_left = Chip.spawn(Vector2(75,50+i*80))
		chip_left.set_sprite(textures[texture_keys[i]])
		chip_left.set_side("left")
		chip_left.set_color(texture_keys[i])
		add_child(chip_left)
	texture_keys.shuffle()
	for i in range(4):
		var chip_right = Chip.spawn(Vector2(580,50+i*80))
		chip_right.set_sprite(textures[texture_keys[i]])
		chip_right.set_side("right")
		chip_right.set_color(texture_keys[i])
		add_child(chip_right)
		
		
func _input(event) -> void:
	if event.is_action_pressed("left_click"):
		# Handle the press: Identify starting point
		var clicked_node = get_closest_node(event.position)
		if clicked_node:
			current_start = clicked_node
	elif event.is_action_released("left_click"):
		# Handle the release: Draw the line to the released point
		if current_start:
			var clicked_node = get_closest_node(event.position)
			if clicked_node and clicked_node != current_start and clicked_node.color==current_start.color:
				connected_lines.append([current_start, clicked_node])
			current_start = null  # Reset after connection
			#queue_redraw()  # Redraw the lines and nodes

func get_closest_node(position) -> Chip:
	for node in get_children():
		if node is Chip:
			if node.position.distance_to(position) <= epsilon:
				return node
		
	return null

func _draw() -> void:
	for line in connected_lines:
		draw_line(line[0].position, line[1].position,line[0].color , 10)  # Red lines for connections
	
	# Draw the current line if connecting
	if current_start:
		draw_line(current_start.position, get_global_mouse_position(), current_start.color, 2)  # Blue temporary line
