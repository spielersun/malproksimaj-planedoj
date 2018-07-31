extends KinematicBody2D

onready var ship_anims = $object

var dead = false

var top_bound
var bottom_bound
var direction = 1
var hanging = true

func _ready():
	randomize()
	
	position.y = 600
	position.x = 450
	ship_anims.play("active")
	
	top_bound = position.y - 2
	bottom_bound = position.y + 2
	
	direction = 1 if rand_range(0,100) > 50 else -1 

func _physics_process(delta):
	if hanging:
		position.y += 7 * direction * delta
	
		if position.y > bottom_bound:
			direction = -1
		elif position.y < top_bound:
			direction = 1
	
