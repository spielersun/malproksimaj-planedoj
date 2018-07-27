extends Area2D

onready var object = $object

export(PackedScene) var explosion

export var speed = 100
export var angle = 0
export var damage = 20

var limiter = 0
var placed = false

var field

func _ready():
	object.play("active")
	connect("body_entered", self, "_on_body_entered")
		
func _process(delta):
	if !placed:
		_move(delta)
	else:
		position = field.position
		detonate()
	if position.x == 50:
		queue_free()

func _move(delta):
	limiter += delta
	
	rotation += 0.1
	position.x -= speed * 2 * delta
	position.y -= 2.5 - (limiter * limiter)

func _on_body_entered(body):
	if body.is_in_group("player"):
		position = body.position
		object.play("placed")
		field = body 
		placed  = true

func detonate():
	yield(belt.create_timer(3.00), "timeout")
	belt.create_explosion(position)
	queue_free()

