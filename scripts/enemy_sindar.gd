extends KinematicBody2D

export var speed = 150
export var health = 15

onready var sprite = $sprite
onready var collision = $shape

export(PackedScene) var ball

var direction = 1
var dead = false
var can_shoot = true
var start_x

signal enemy_dead

func _ready():
	start_x = position.x
	sprite.play("move")
	
func _process(delta):
	position.x -= speed * delta
	
	if position.x < start_x-3000:
		queue_free()

func add_damage(damage):
	health -= damage
	if health <= 0:
		dead = true
		emit_signal("enemy_dead", "sindar")
		queue_free()