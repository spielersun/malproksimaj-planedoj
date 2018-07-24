extends Area2D

onready var object = $object

var speed = 100
var health = 10

func _ready():
	object.play("idle")
	object.connect("animation_finished", self, "animation_changed")

func _process(delta):
	position.x -= delta * speed

func bullet_hit(damage):
	health -= damage
	if health <= 0:
		object.play("fall")

func animation_changed():
	if object.animation == "fall":
		queue_free()