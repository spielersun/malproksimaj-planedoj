extends Area2D

export var speed = 200
export var angle = 0

func _ready():
	connect("body_entered", self, "_on_body_entered")
	
func _process(delta):
	_move(delta)
	
	if position.x < -2000:
		queue_free()

func _move(delta):
	rotation = angle
	position.x += cos(angle) * (speed * delta)
	position.y += sin(angle) * (speed * delta)
	
func _on_body_entered(area):
	if area.is_in_group("enemy"):
		queue_free()