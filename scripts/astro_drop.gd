extends Area2D

export var speed = 200
export var damage = 5

var origin_pos

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	if origin_pos == "east":
		position.x -= (speed * delta)
	elif origin_pos == "west":
		position.x += (speed * delta)
	
	if position.x < -500:
		queue_free()
	elif position.x > 2000:
		queue_free()
