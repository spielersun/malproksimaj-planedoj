extends KinematicBody2D

var angle 
var speed = 300

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	position.x += cos(angle) * (speed * delta)
	position.y += sin(angle) * (speed * delta)
