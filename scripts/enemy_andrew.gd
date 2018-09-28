extends KinematicBody2D

export var speed = 100
export var health = 15
export var value = 10

onready var object = $object
onready var collision = $shape

var target_pos
var left_bound
var right_bound

var direction = 1
var dead = false
var start_x

var cannon_active = false

signal enemy_dead

func _ready():
	start_x = position.x
	object.connect("animation_finished", self, "animation_changed")
	
	object.play("passive")
	left_bound = position.y - 100
	right_bound = position.y + 100
	
	direction = 1 if rand_range(0,100) > 50 else -1 
	
	yield(belt.create_timer(rand_range(1.00, 2.00)), "timeout")
	object.play("energize")

func _process(delta):
	position.x -= speed * delta
	position.y += speed * direction * delta
	
	if position.y > right_bound:
		direction = -1
	elif position.y < left_bound:
		direction = 1
	
	if position.x < start_x - 3000:
		queue_free()

func add_damage(damage):
	health -= damage
	if health <= 0:
		emit_signal("enemy_dead", value)
		dead = true
		queue_free()
		
func animation_changed():
	if object.animation == "energize":
		object.play("active")
		cannon_active = true
		
func shoot():
	object.play("energize")