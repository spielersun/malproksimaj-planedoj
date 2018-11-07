extends KinematicBody2D

const UP = Vector2(0, -1)
const GRAVITY = 20
const ACCELERATION = 50
const MAX_SPEED = 200
const JUMP_HEIGHT = 500
const SPEED = 100

var motion = Vector2()

onready var sprites = $sprites

var direction = 1

func _ready():
	pass

func _physics_process(delta):
	
	motion.y += GRAVITY
	var friction = false
	
	if Input.is_action_pressed("ui_right"):
		motion.x += ACCELERATION
		motion.x = min(motion.x+ACCELERATION, MAX_SPEED)
		$sprites.flip_h = false
		$sprites.play("active")
	elif Input.is_action_pressed("ui_left"):
		motion.x -= ACCELERATION
		motion.x = max(motion.x-ACCELERATION, -MAX_SPEED)
		$sprites.flip_h = true
		$sprites.play("active")
	else: 
		$sprites.play("passive")
		friction = true
	
	if is_on_floor():
		if Input.is_action_just_pressed("ui_up"):
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
