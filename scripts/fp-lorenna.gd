extends KinematicBody2D

onready var spawner = get_tree().get_root().get_node("fp-test").find_node("fp-enemy-spawner")

export var speed = 100
export var health = 5

onready var ship_anims = $ship
onready var collision = $shape

var dead = false 

func _process(delta):
	move(delta)
	
	if position.x < -100:
		queue_free()
		
func move(delta):
	position.x -= speed * delta
	
func add_damage(damage):
	health -= damage
	if health <= 0:
		print(spawner.name)
		dead = true
		spawner.lorenna_presence = false
		queue_free()