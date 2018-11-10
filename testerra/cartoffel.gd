extends KinematicBody2D

export(PackedScene) var bullet

const UP = Vector2(0, -1)
const GRAVITY = 20
const ACCELERATION = 50
const MAX_SPEED = 200
const JUMP_HEIGHT = 500
const SPEED = 100
const BULLET_SPEED = 200

var motion = Vector2()

var mouse_angle
var relative_height
var relative_width

onready var sprites = $sprites
onready var turret = $turret
onready var beam = $beam

var direction = 1

func _ready():
	pass

func _physics_process(delta):
	
	var deg_angle
	
	relative_height = get_global_mouse_position().y - position.y
	relative_width = get_global_mouse_position().x - position.x
	
	if relative_width == 0:
		mouse_angle = atan(relative_height)
	elif relative_height == 0:
		mouse_angle = atan(relative_width)
	else:
		mouse_angle = atan(relative_height/relative_width)

	if relative_width <= 0:
		deg_angle = rad2deg(mouse_angle) + 180
	else:
		deg_angle = rad2deg(mouse_angle)

	turret.rotation = rotation + deg2rad(deg_angle)
	
	
	motion.y += GRAVITY
	var friction = false
	
	if Input.is_action_pressed("fp_forward"):
		motion.x += ACCELERATION
		motion.x = min(motion.x+ACCELERATION, MAX_SPEED)
		$sprites.flip_h = false
		$sprites.play("active")
	elif Input.is_action_pressed("fp_backwards"):
		motion.x -= ACCELERATION
		motion.x = max(motion.x-ACCELERATION, -MAX_SPEED)
		$sprites.flip_h = true
		$sprites.play("active")
	else: 
		$sprites.play("passive")
		friction = true
	
	if is_on_floor():
		if Input.is_action_just_pressed("fp_up"):
			#print(motion.y)
			motion.y = -JUMP_HEIGHT
		if friction:
			motion.x = lerp(motion.x, 0, 0.2)
	else:
		if motion.y < 0:
			$sprites.play("active")
		else:
			$sprites.play("active")
			
		if friction:
			motion.x = lerp(motion.x, 0, 0.05)
		
	motion = move_and_slide(motion, UP)
	
	if Input.is_action_just_pressed("fp_shoot"):
		shoot(delta)

func shoot(delta):
	var new_bullet = bullet.instance()
	var turret_angle = turret.rotation
	# print(turret_angle)
	
	var bullet_x = (position.x + 5) + (27 * cos(turret_angle))
	var bullet_y = (position.y + 12) + (27 * sin(turret_angle))
	
	beam.play()
	
	new_bullet.speed = BULLET_SPEED + SPEED
	new_bullet.angle = turret_angle
	new_bullet.position = Vector2(bullet_x, bullet_y) 
	new_bullet.start_x = bullet_x
	
	get_parent().add_child(new_bullet)
