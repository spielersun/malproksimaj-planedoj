extends Area2D

onready var object = $object

export var speed = 100
export var angle = 0
export var damage = 20

var limiter = 0

func _ready():
	object.play("active")
	
func _process(delta):
	_move(delta)
	if position.x == 50:
		queue_free()

func _move(delta):
	limiter += delta
	
	rotation += 0.1
	position.x -= speed * 2 * delta
	position.y -= 2.5 - (limiter * limiter)
