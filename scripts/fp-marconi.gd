extends KinematicBody2D

export var speed = 100
export var health = 15

onready var ship_anims = $ship
onready var collision = $shape

var target_pos
var left_bound
var right_bound

var direction = 1
var dead = false
var can_shoot = true

signal marconi_defeated

func _ready():
	ship_anims.play("idle")
	left_bound = position.y - 100
	right_bound = position.y + 100
	
	direction = 1 if rand_range(0,100) > 50 else -1 

func _process(delta):
	movement(delta)
	position.y += speed * direction * delta
	
	if position.y > right_bound:
		direction = -1
	elif position.y < left_bound:
		direction = 1

func movement(delta):
	position.x -= speed * delta

func add_damage(damage):
	health -= damage
	if health <= 0:
		dead = true
		collision.queue_free()
		hide()
		emit_signal("marconi_defeated")
