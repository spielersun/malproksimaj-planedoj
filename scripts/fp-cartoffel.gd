extends KinematicBody2D

export (float) var rotation_speed = 2
export var speed = 100

export(PackedScene) var bullet
export(PackedScene) var shield
export(PackedScene) var drop

onready var engine = $engine
onready var turret = $turret
onready var ship_anims = $ship
onready var beam = $beam

var accelerated = false
var descending = false
var landed = false

var armor = 5 setget took_hit
var double_shooting = false setget set_double_shooting

var mouse_angle
var relative_height
var relative_width

func _ready():
	ship_anims.connect("animation_finished", self, "animation_changed")
	
func _process(delta):
	if descending:
		position.y += delta * speed
		print(position.y)
		if position.y >= 800:
			landed = true
			descending = false
			print(landed)
	if landed:
		if Input.is_action_just_pressed("fp_forward"):
			ship_anims.play("ride")
	else:
		if Input.is_action_just_pressed("fp_forward"):
			engine.play()
			ship_anims.play("start-right")
		elif Input.is_action_just_released("fp_forward"):
			engine_stop()
	
	if Input.is_action_just_pressed("fp_shoot"):
		if double_shooting:
			double_shoot()
		else:
			shoot()

	if Input.is_action_just_pressed("fp_drop"):
		drop()
	if Input.is_action_pressed("fp_transform"):
		transform()
					
func _physics_process(delta):
	var deg_angle
	
	relative_height = get_global_mouse_position().y - position.y
	relative_width = get_global_mouse_position().x - position.x
	mouse_angle = atan(relative_height/relative_width)
	
	if relative_width <= 0:
		deg_angle = rad2deg(mouse_angle) + 180
	else:
		deg_angle = rad2deg(mouse_angle)
	
	turret.rotation = deg2rad(deg_angle)
	
	# var motion = (get_global_mouse_position().y - position.y) * 10 * delta
	# translate(Vector2(0, motion))
	
	var view_size = get_viewport_rect().size
	position.y = clamp(position.y, 0 + 100, view_size.y - 100)
	
	# if Input.is_action_pressed("turret_down"):
	# 	turret.rotation += rotation_speed * delta
	# elif Input.is_action_pressed("turret_up"):
	# 	turret.rotation -= rotation_speed * delta
	
	if Input.is_action_pressed("fp_down"):
		position.y += speed * delta
	elif Input.is_action_pressed("fp_up"):
		position.y -= speed * delta

func animation_changed():
	if ship_anims.animation == "start-right":
		ship_anims.play("move-right")
	elif ship_anims.animation == "move-right":
		ship_anims.play("cruise-right")

func shoot():
	var new_bullet = bullet.instance()
	var turret_angle = turret.rotation
	# print(turret_angle)
	
	var bullet_x = (position.x + 10) + (40 * cos(turret_angle))
	var bullet_y = (position.y + 20) + (40 * sin(turret_angle))
	
	beam.play()
	
	get_parent().add_child(new_bullet)
	new_bullet.angle = turret_angle
	new_bullet.position = Vector2(bullet_x, bullet_y) 

func drop():
	var new_drop = drop.instance()
	new_drop.position = Vector2(position.x + 20, position.y + 40) 
	get_parent().add_child(new_drop)
	
func double_shoot():
	var new_bullet_up = bullet.instance()
	var turret_angle_up = turret.rotation + 0.1
	
	var new_bullet_down = bullet.instance()
	var turret_angle_down= turret.rotation - 0.1
	
	# print(mouse_angle)
	# print(turret_angle)
	
	var bullet_x_up = (position.x + 10) + (40 * cos(turret_angle_up))
	var bullet_y_up = (position.y + 20) + (40 * sin(turret_angle_up))
	
	var bullet_x_down = (position.x + 10) + (40 * cos(turret_angle_down))
	var bullet_y_down = (position.y + 20) + (40 * sin(turret_angle_down))
	
	beam.play()
	beam.play()
	
	get_parent().add_child(new_bullet_up)
	get_parent().add_child(new_bullet_down)
	
	new_bullet_up.angle = turret_angle_up
	new_bullet_up.position = Vector2(bullet_x_up, bullet_y_up) 
	
	new_bullet_down.angle = turret_angle_down
	new_bullet_down.position = Vector2(bullet_x_up, bullet_y_down) 

func set_double_shooting(value):
	double_shooting = value
	
	if double_shooting:
		yield(create_timer(5), "timeout")
		double_shooting = false
	
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
	
func create_timer(wait_time):
	var timer = Timer.new()
	timer.set_wait_time(wait_time)
	timer.set_one_shot(true)
	timer.connect("timeout", timer, "queue_free")
	add_child(timer)
	timer.start()
	return timer
	
func transform():
	descending = true
	ship_anims.play("eject-tires")
	