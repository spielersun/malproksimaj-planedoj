extends Area2D

export var speed = 200
export var angle = 0
export var damage = 5

func _ready():
	connect("area_entered", self, "_on_area_entered")

func _process(delta):
	position.x += speed * delta
	
	if position.x > 1650 or position.x < 50:
		queue_free()

func _on_area_entered(area):
	if area.is_in_group("breakable_wall"):
		area.shatter()
		queue_free()