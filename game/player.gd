class_name Player
extends CharacterBody3D

const GRAVITY = 98

@export var mouse_sensitivity = 0.15
@onready var head = $Head
@onready var camera = $Head/Camera

var speed = Vector3.ZERO
var surface_accel = 100
var surface_friction = 48
var in_minigame := false
var fullscreen = false

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	if !in_minigame:
		if event is InputEventMouseMotion:
			rotate_y(deg_to_rad(-event.relative.x * mouse_sensitivity))
			head.rotate_x(deg_to_rad(-event.relative.y * mouse_sensitivity))
			head.rotation.x = clamp(head.rotation.x, -PI/2, PI/2)

func _physics_process(delta):
	if !in_minigame:
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
		move_and_slide()
		
		$Head/Camera/Hand.interact = false
		if $Head/Front.get_collider():
			var object = $Head/Front.get_collider()
			
			if object is Interactable:
				if object.is_interactable(self):
					$Head/Camera/Hand.interact = true
					if Input.is_action_just_pressed("interact"):
						object.interact(self)
				#else: hide_tooltip()
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED_HIDDEN)

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
	return support_instance

func set_blur(value):
	$Head/Camera/Blur.material.set_shader_parameter("sigma", value)

func end_minigame():
	var tween = create_tween()
	tween.tween_method(set_blur, 3.0, .1, .5).set_ease(Tween.EASE_IN_OUT)
	tween.tween_callback(func(): in_minigame = false; Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED))
