extends CharacterBody3D

@export var mouse_sensitivity = 0.15
@onready var head = $Head
@onready var camera = $Head/Camera

var speed = Vector3.ZERO
var surface_accel = 1
var surface_friction = 48

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(deg_to_rad(-event.relative.x * mouse_sensitivity))
		head.rotate_x(deg_to_rad(-event.relative.y * mouse_sensitivity))
		head.rotation.x = clamp(head.rotation.x, -PI/2, PI/2)

func _physics_process(delta):
	move_and_collide(speed * delta * 70)
	
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
	
	speed *= surface_friction * delta

func _process(delta):
	if Input.is_action_just_pressed("escape"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if Input.is_action_just_pressed("left_click"):
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
