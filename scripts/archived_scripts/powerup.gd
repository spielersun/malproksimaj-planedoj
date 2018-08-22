extends Area2D

var velocity = Vector2(-200, 0)

func _ready():
	set_process(true)
	pass

func _process(delta):
	translate(velocity * delta)
	
	if position.x <= 0:
		queue_free()
	pass