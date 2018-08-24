extends KinematicBody2D

export(PackedScene) var rocket

export var speed = 200
export var angle = 0

onready var engine = $engine
onready var ball = $ball
onready var ball_animation = $ball/anim
onready var ship_anims = $ship

var mouse_angle
var relative_height
var relative_width

var on_point = false
var engine_active = false
var ball_ready = false
var have_rocket = true
var is_glove = false

func _ready():
	ship_anims.play("idle")
	ship_anims.connect("animation_finished", self, "animation_changed")

func _physics_process(delta):
	var deg_angle
	
	relative_height = get_global_mouse_position().y - position.y
	relative_width = get_global_mouse_position().x - position.x
	
	mouse_angle = atan(relative_height/relative_width)
	
	if relative_width <= 0:
		deg_angle = rad2deg(mouse_angle) + 180
	else:
		deg_angle = rad2deg(mouse_angle)
	
	if abs(relative_width) <= 10 and abs(relative_height) <= 10:
		on_point = true
	else:
		on_point = false
		
	angle = deg2rad(deg_angle)
	rotation = angle
	
	if !on_point and engine_active:
		position.x += cos(angle) * (speed * delta)
		position.y += sin(angle) * (speed * delta)
		
	if Input.is_action_just_pressed("fp_forward"):
		engine.play()
		engine_active = true
		if !is_glove:
			ship_anims.play("start")
		else:
			ship_anims.play("sides-start")
	elif Input.is_action_just_released("fp_forward"):
		engine.stop()
		engine_active = false
		if !is_glove:
			ship_anims.play("idle")
		else:
			ship_anims.play("sides-idle")
	
	if Input.is_action_pressed("fp_auxiliary"):
		ball_ready = true
		ball_animation.play("ball_out")
		
	if Input.is_action_pressed("fp_transform"):
		if ball_ready and have_rocket:
			batfinger()
	
func animation_changed():
	if ship_anims.animation == "start":
		ship_anims.play("move")
	elif ship_anims.animation == "side-start":
		ship_anims.play("sides-move")

func batfinger():
	have_rocket = false
	ship_anims.play("sides")
	ball.hide()
	var new_rocket = rocket.instance()
	
	new_rocket.angle = rotation
	new_rocket.rotation = rotation
	new_rocket.position = position

	get_parent().add_child(new_rocket)
	batglove()

func batglove():
	is_glove = true
	ship_anims.play("sides-transform")


