extends Area2D

export(PackedScene) var explosion_big

onready var object = $object

export var speed = 250
export var damage = 5

var origin_pos
var scatter_constant

func _ready():
	randomize()
	scatter_constant = rand_range(-100, 100)
	object.play("active")
	connect("body_entered", self, "_on_body_entered")

func _process(delta):
	rotation += 0.1
	
	if origin_pos == "east":
		position.x -= (speed * delta)
		position.y += (scatter_constant * delta)
	elif origin_pos == "west":
		position.x += (speed * delta)
		position.y -= (scatter_constant * delta)
	elif origin_pos == "north":
		position.y += (speed * delta)
		position.x -= (scatter_constant * delta)
	elif origin_pos == "south":
		position.y -= (speed * delta)
		position.x += (scatter_constant * delta)
	
	if position.x < -500:
		queue_free()
	elif position.x > 2100:
		queue_free()
	
	if position.y < -500:
		queue_free()
	elif position.y > 1400:
		queue_free()

func _on_body_entered(area):
	if area.is_in_group("player"):
		var new_explosion = explosion_big.instance()
		new_explosion.position = position
		get_parent().add_child(new_explosion)
		queue_free()