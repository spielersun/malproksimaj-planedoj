extends KinematicBody2D

export var speed = 100

onready var engine = $engine
onready var bus_anims = $bus

func _ready():
	pass

func _process(delta):
	if Input.is_action_just_pressed("ui_right"):
		engine.play()
		bus_anims.play("move-right")
	elif Input.is_action_just_released("ui_right"):
		engine.stop()
		bus_anims.play("idle")
		
	if Input.is_action_pressed("ui_up"):
		jump(delta)
		

func jump(delta):
	bus_anims.play("jump")
	yield(bus_anims, "animation_finished")
	position.y -= speed * delta
	