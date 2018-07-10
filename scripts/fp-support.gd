extends Area2D

var velocity
var angle

func _ready():
	pass

func _process(delta):
	randomize()
	velocity = Vector2(rand_range(-250, -150), rand_range(0, 100))
	
	translate(velocity * delta)
	rotation += delta
	
	if position.x <= 0:
		queue_free()
