extends KinematicBody2D

export var speed = 100

onready var ball = $ball
onready var ship_anims = $ship

func _ready():
	ship_anims.play("idle")
	ship_anims.connect("animation_finished", self, "animation_changed")

func _physics_process(delta):
	if Input.is_action_just_pressed("fp_forward"):
		ship_anims.play("start")
	elif Input.is_action_just_released("fp_forward"):
		ship_anims.play("idle")

func animation_changed():
	if ship_anims.animation == "start":
		ship_anims.play("move")
