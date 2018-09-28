extends KinematicBody2D

export var health = 10
export var value = 2
var dead = false

signal enemy_dead

func _ready():
	pass

func add_damage(damage):
	health -= damage
	if health <= 0:
		emit_signal("enemy_dead", value)
		dead = true
		queue_free()