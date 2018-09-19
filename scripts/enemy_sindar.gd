extends KinematicBody2D

export var speed = 150
export var health = 15

onready var ship_anims = $object
onready var collision = $shape

onready var path = $path

onready var follow = $path/follow
onready var follow2 = $path/follow2
onready var follow3 = $path/follow3
onready var follow4 = $path/follow4
onready var follow5 = $path/follow5

export(PackedScene) var ball

var direction = 1
var dead = false
var can_shoot = true

func _ready():
	position.y = 750
	ship_anims.play("move")
	
func _process(delta):
	position.x -= speed * delta
	
	if position.x < -100:
		queue_free()

func add_damage(damage):
	health -= damage
	if health <= 0:
		dead = true
		queue_free()