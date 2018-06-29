extends KinematicBody2D

export (float) var rotation_speed = 2
export var speed = 100

export(PackedScene) var bullet

onready var engine = $engine
onready var turret = $turret

func _ready():
	pass

func _process(delta):
	if Input.is_action_just_pressed("ui_right"):
		engine.play()
	elif Input.is_action_just_released("ui_right"):
		engine.stop()
	
	if Input.is_action_just_pressed("shoot"):
		shoot()

func _physics_process(delta):
	if Input.is_action_pressed("turret_down"):
		turret.rotation += rotation_speed * delta
	elif Input.is_action_pressed("turret_up"):
		turret.rotation -= rotation_speed * delta
	
	if Input.is_action_pressed("ui_down"):
		position.y += speed * delta
	elif Input.is_action_pressed("ui_up"):
		position.y -= speed * delta
 
func shoot():
	var new_bullet = bullet.instance()
	var turret_angle = turret.rotation
	var bullet_x = (position.x - turret.offset.x) + (30 * cos(turret_angle))
	var bullet_y = (position.y - turret.offset.y) + (5 * sin(turret_angle))
	
	print(position.x)
	print(position.y)
	print(turret.offset.x)
	print(turret.offset.y)
	
	get_parent().add_child(new_bullet)
	new_bullet.angle = turret_angle
	new_bullet.position = Vector2(bullet_x, bullet_y) 
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	