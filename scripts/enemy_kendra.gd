extends KinematicBody2D

export var speed = 100
export var health = 15

onready var sprites = $sprites
onready var collision = $shape

onready var path = $path

onready var follow = $path/follow
onready var follow2 = $path/follow2
onready var follow3 = $path/follow3
onready var follow4 = $path/follow4
onready var follow5 = $path/follow5

export(PackedScene) var ball

var target_pos
var left_bound
var right_bound

var direction = 1
var dead = false
var can_shoot = true
var start_x

signal enemy_dead

func _ready():
	start_x = position.x
	sprites.play("move")
	
	left_bound = position.y - 100
	right_bound = position.y + 100
	
	direction = 1 if rand_range(0,100) > 50 else -1 
	
	follow.unit_offset = 0.1
	follow2.unit_offset = 0.2
	follow3.unit_offset = 0.3
	follow4.unit_offset = 0.4
	follow5.unit_offset = 0.5
	
func _process(delta):
	position.x -= speed * delta
	position.y += speed * direction * delta
	
	if position.y > right_bound:
		direction = -1
	elif position.y < left_bound:
		direction = 1
	
	if position.x < start_x-3000:
		queue_free()
		
	follow.offset += speed * 10 * delta
	follow2.offset += speed * 10 * delta
	follow3.offset += speed * 10 * delta
	follow4.offset += speed * 10 * delta
	follow5.offset += speed * 10 * delta

func add_damage(damage):
	health -= damage
	if health <= 0:
		dead = true
		emit_signal("enemy_dead", "kendra")
		queue_free()
