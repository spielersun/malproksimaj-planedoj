extends KinematicBody2D

export var speed = 100
export var health = 15

export(PackedScene) var bullet

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
	
	while !dead:
		shoot()
		yield(create_timer(rand_range(1.50, 3.00)), "timeout")

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
		queue_free()
		hide()
		emit_signal("marconi_defeated")

func create_timer(wait_time):
	var timer = Timer.new()
	timer.set_wait_time(wait_time)
	timer.set_one_shot(true)
	timer.connect("timeout", timer, "queue_free")
	add_child(timer)
	timer.start()
	return timer

func shoot():
	var new_bullet = bullet.instance()
	var bullet_x = (position.x + 10)
	var bullet_y = (position.y + 20)
	
	get_parent().add_child(new_bullet)
	new_bullet.position = Vector2(bullet_x, bullet_y) 