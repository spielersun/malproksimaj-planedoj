extends KinematicBody2D

export var health = 10
var dead = false

onready var collision = $shape

func _ready():
	pass

func add_damage(damage):
	health -= damage
	if health <= 0:
		dead = true
		queue_free()