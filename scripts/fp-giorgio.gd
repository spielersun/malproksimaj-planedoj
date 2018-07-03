extends KinematicBody2D

export var speed = 100

onready var ship_anims = $ship

var target_pos
var left_bound
var right_bound

var direction = 1

func _ready():
	ship_anims.play("move-left")
	left_bound = position.y - 100
	right_bound = position.y + 100
	
	direction = 1 if rand_range(0,100) > 50 else -1 

func _process(delta):
	movement(delta)
	position.y += speed * direction * delta
	
	if position.y > right_bound:
		direction = -1
	elif position.y < left_bound:
		direction = 1

func movement(delta):
	position.x -= speed * delta