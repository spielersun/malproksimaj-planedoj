extends KinematicBody2D

export var speed = 100
export var health = 50

onready var ship_anims = $sprite
onready var collision = $shape

var target_pos
var top_bound
var bottom_bound

var direction = 1
var dead = false
var can_shoot = true
var max_health = 50

signal health_changed
signal giorgio_defeated

func _ready():
	ship_anims.play("move-left")
	bottom_bound = position.y - 100
	top_bound = position.y + 100
	
	direction = 1 if rand_range(0,100) > 50 else -1 

func _process(delta):
#	position.x -= speed * delta
	position.y += speed * direction * delta
	
	if position.y > top_bound:
		direction = -1
	elif position.y < bottom_bound:
		direction = 1
	
#	if position.x < -100:
#		queue_free()

func add_damage(damage):
	health -= damage
	emit_signal('health_changed', health * 100/max_health)
	if health <= 0:
		dead = true
		queue_free()
#		collision.queue_free()
#		hide()
		emit_signal("giorgio_defeated")
