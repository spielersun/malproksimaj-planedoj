extends Area2D

onready var object = $object

var speed = 100

func _ready():
	object.play("idle")

func _process(delta):
	position.x -= delta * speed
