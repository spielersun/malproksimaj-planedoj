extends Area2D

export var speed = 200
export var angle = 0

func _process(delta):
	_move(delta)
	
	if position.x < -2000:
		queue_free()

func _move(delta):
	rotation = angle
	position.x += cos(angle) * (speed * delta)
	position.y += sin(angle) * (speed * delta)