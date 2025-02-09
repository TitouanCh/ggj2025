class_name Player
extends CharacterBody3D

signal faded_to_black

const GRAVITY = 120

@export var mouse_sensitivity = 0.15
@onready var head = $Head
@onready var camera = $Head/Camera

var speed = Vector3.ZERO
var surface_accel = 100
var surface_friction = 48
var in_minigame := false
var current_minigame_name = null
var fullscreen = false
var fall = false
var in_intro = false
var distance_covered = 0.0

func _ready():
	if !Task.schedule[Task.current_day].letter:
		set_day()
	else:
		$Head/Camera/Letter.finished.connect(func(): set_day(); in_intro = false)
		in_intro = true
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	Task.set_player(self)

func set_day():
	var text_tween = create_tween()
	text_tween.tween_property($Head/Camera/FadeToBlack/RichTextLabel, "modulate", Color(255, 255, 255, 1), 1).set_ease(Tween.EASE_IN)
	$Head/Camera/FadeToBlack/RichTextLabel.text = "\n\n[wave amp=50.0 freq=5.0 connected=1][center]DAY   %s[/center][/wave]" % (Task.current_day + 1)
	var tween = create_tween()
	tween.tween_callback(func(): Sound.play_sound_from_stream(Task.schedule[Task.current_day].jingle, 0, -1))
	tween.tween_interval(1)
	tween.tween_property($Head/Camera/FadeToBlack, "modulate", Color(255, 255, 255, 0), 5).set_ease(Tween.EASE_IN)
	tween.tween_callback(func(): $Head/Camera/FadeToBlack/RichTextLabel.visible = false)

func _input(event):
	if !in_minigame:
		if event is InputEventMouseMotion:
			rotate_y(deg_to_rad(-event.relative.x * mouse_sensitivity))
			head.rotate_x(deg_to_rad(-event.relative.y * mouse_sensitivity))
			head.rotation.x = clamp(head.rotation.x, -PI/2, PI/2)

func _physics_process(delta):
	$Head/Camera/Cursor.visible = !in_minigame
	if !in_minigame and !in_intro:
		# Mouvement
		var direction = Vector2.ZERO
		
		if Input.is_action_pressed("foward"):
			direction.y += 1
		if Input.is_action_pressed("backward"):
			direction.y -= 1 
		if Input.is_action_pressed("right"):
			direction.x -= 1
		if Input.is_action_pressed("left"):
			direction.x += 1
		
		if direction.length_squared() > 0:
			speed.x -= surface_accel * delta * sin(rotation.y + direction.angle_to(Vector2(0, 1)))
			speed.z -= surface_accel * delta * cos(rotation.y + direction.angle_to(Vector2(0, 1)))
		
		speed.y -= GRAVITY * delta
		
		speed *= surface_friction * delta
		
		velocity = speed * delta * 70
		
		distance_covered += velocity.length()
		if distance_covered > 5400.0 and !$Head/Camera/Bulle.go:
			$Head/Camera/Bulle.come_over()
			$Head/Camera/Bulle.go = true

		if velocity.length() > 10:
			if $AudioStreamPlayer.playing:
				$AudioStreamPlayer.stream_paused = false
			else:
				$AudioStreamPlayer.play()
		else:
			$AudioStreamPlayer.stream_paused = true

		move_and_slide()
		
		$Head/Camera/Hand.interact = false
		if $Head/Front.get_collider():
			var object = $Head/Front.get_collider()
			
			if object is Interactable:
				if object.is_interactable(self):
					$Head/Camera/Hand.interact = true
					if Input.is_action_just_pressed("interact"):
						object.interact(self)
				elif object is MachineSoda:
					if Input.is_action_just_pressed("interact"):
						start_minigame("none")
				#else: hide_tooltip()
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED_HIDDEN)
		$AudioStreamPlayer.stream_paused = true
	
	if position.y < -1 and !fall:
		var tween = create_tween()
		Sound.play_sound_from_name("requiem2.mp3")
		tween.tween_interval(1)
		tween.tween_callback(func(): Sound.play_sound_from_name("crie.mp3"))
		Task.complete_task("Fall")
		fall = true

func _process(delta):
	if Input.is_action_just_pressed("escape"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if Input.is_action_just_pressed("left_click") and !in_minigame:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	if Input.is_action_just_pressed("fullscreen"):
		fullscreen = !fullscreen 
		if fullscreen: DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		else: DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED) 


func start_minigame(minigame: String) -> Support:
	var support_instance = Support.spawn_support(minigame)
	camera.add_child(support_instance)
	in_minigame = true
	support_instance.finished.connect(end_minigame)
	support_instance.position = Vector2.ZERO
	var tween = create_tween()
	tween.tween_method(set_blur, 0.1, 3.0, .5).set_ease(Tween.EASE_IN_OUT)
	$Head/Camera/Hand.interact = false
	current_minigame_name = minigame
	return support_instance

func set_blur(value):
	$Head/Camera/Blur.material.set_shader_parameter("sigma", value)

func fade_to_black():
	var tween = create_tween()
	tween.tween_interval(1)
	tween.tween_property($Head/Camera/FadeToBlack, "modulate", Color(255, 255, 255, 1), 5).set_ease(Tween.EASE_IN)
	tween.tween_callback(func(): faded_to_black.emit())

func end_minigame():
	var tween = create_tween()
	tween.tween_method(set_blur, 3.0, .1, .5).set_ease(Tween.EASE_IN_OUT)
	tween.tween_callback(func(): in_minigame = false; Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED))
	Task.complete_task("Play" + (current_minigame_name.to_pascal_case()))
	current_minigame_name = null
