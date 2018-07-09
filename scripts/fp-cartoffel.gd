extends KinematicBody2D

export (float) var rotation_speed = 2
export var speed = 100

export(PackedScene) var bullet
export(PackedScene) var shield

onready var engine = $engine
onready var turret = $turret
onready var ship_anims = $ship
onready var beam = $beam

var accelerated = false
var armor = 5 setget took_hit

var mouse_angle

func _ready():
	pass
	
func _process(delta):
	if Input.is_action_just_pressed("fp_forward"):
		engine.play()
		if accelerated:
			ship_anims.play("move-right")
		else:
			ship_anims.play("start-right")
	elif Input.is_action_just_released("fp_forward"):
		engine_stop()
	
	if Input.is_action_just_pressed("fp_shoot"):
		shoot()

func _physics_process(delta):
	
	var relative_height = get_global_mouse_position().y - position.y
	var relative_width = get_global_mouse_position().x - position.x
	mouse_angle = atan(relative_height/relative_width)
	turret.rotation = mouse_angle
	
	# var motion = (get_global_mouse_position().y - position.y) * 10 * delta
	# translate(Vector2(0, motion))
	
	var view_size = get_viewport_rect().size
	position.y = clamp(position.y, 0 + 15, view_size.y - 15)
	
	# if Input.is_action_pressed("turret_down"):
	# 	turret.rotation += rotation_speed * delta
	# elif Input.is_action_pressed("turret_up"):
	# 	turret.rotation -= rotation_speed * delta
	
	if Input.is_action_pressed("fp_down"):
		position.y += speed * delta
	elif Input.is_action_pressed("fp_up"):
		position.y -= speed * delta
 
func shoot():
	var new_bullet = bullet.instance()
	var turret_angle = turret.rotation
	# print(mouse_angle)
	# print(turret_angle)
	
	var bullet_x = (position.x + 10) + (40 * cos(turret_angle))
	var bullet_y = (position.y + 20) + (40 * sin(turret_angle))
	
	beam.play()
	
	get_parent().add_child(new_bullet)
	new_bullet.angle = turret_angle
	new_bullet.position = Vector2(bullet_x, bullet_y) 

func engine_stop():
	engine.stop()
	accelerated = false
	ship_anims.play("idle")

func took_hit(new_value):
	if new_value > 4:
		hit_shield()
		return
	elif new_value <= 0:
		queue_free()
	else:
		armor = new_value
		hit_shield()
	
func hit_shield():
	var new_hit = shield.instance()
	new_hit.position = position
	get_parent().add_child(new_hit)
	
	
	
	
	
	
	