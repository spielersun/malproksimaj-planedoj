extends KinematicBody2D

export (float) var rotation_speed = 2
export var speed = 0

export (int) var engine_thrust
export (int) var spin_thrust

export(PackedScene) var bullet
export(PackedScene) var shield
export(PackedScene) var drop

onready var engine = $engine
onready var turret = $turret
onready var ship_anims = $ship
onready var beam = $beam

onready var hull = $hull
onready var roll = $roll

var accelerated = false
var descending = false
var ascending = false
var landed = false
var hanging = false
var shifted_2 = false

var armor = 5 setget took_hit
var double_shooting = false setget set_double_shooting

var mouse_angle
var relative_height
var relative_width

var top_bound
var bottom_bound

var direction = 1
var ship_height = 0

var bullet_speed = 200

var gear_1 = 100
var gear_2 = 300
var rotation_dir = 0
var screensize
var gear = 0

var dragging
var drag_start = Vector2()

func _ready():
	randomize()
	wait()
	
	ship_anims.connect("animation_finished", self, "animation_changed")
	connect("body_entered", self, "_on_body_entered")
	
	screensize = get_viewport().get_visible_rect().size
	direction = 1 if rand_range(0,100) > 50 else -1 
	ship_height = position.y
	
func _process(delta):
	get_input()

func get_input():
	if Input.is_action_pressed("fp_forward"):
		if shifted_2:
			gear = 2
		else:
			gear = 1
	elif Input.is_action_just_released("fp_forward"):
		shifted_2 = false
		gear = 0
	
#	if Input.is_action_pressed("fp_auxiliary"):
#		apply_impulse(Vector2(0, 0), Vector2(30, 0))
#	rotation_dir = 0
#	if Input.is_action_pressed("fp_down"):
#		rotation_dir += 1
#	if Input.is_action_pressed("fp_up"):
#		rotation_dir -= 1

func _physics_process(delta):
	#print(speed)
	var deg_angle
	
	top_bound = ship_height - 2
	bottom_bound = ship_height + 2
	
	if gear == 1 and speed < gear_1:
		speed += 100 * delta
	elif gear == 2 and speed < gear_2:
		speed += 100 * delta
	elif gear == 0 and speed > 0:
		speed -= 100 * delta
	
	position.x += speed * delta

	relative_height = get_global_mouse_position().y - position.y
	relative_width = get_global_mouse_position().x - position.x
	
	if relative_width == 0:
		mouse_angle = atan(relative_height)
	elif relative_height == 0:
		mouse_angle = atan(relative_width)
	else:
		mouse_angle = atan(relative_height/relative_width)

	if relative_width <= 0:
		deg_angle = rad2deg(mouse_angle) + 180
	else:
		deg_angle = rad2deg(mouse_angle)

	turret.rotation = rotation + deg2rad(deg_angle)
	
	# turret.rotation = (get_global_mouse_position() - position).angle()

	# var motion = (get_global_mouse_position().y - position.y) * 10 * delta
	# translate(Vector2(0, motion))

	# var view_size = get_viewport_rect().size
	#  position.y = clamp(position.y, 0 + 100, view_size.y - 100)

	# if Input.is_action_pressed("turret_down"):
	# 	turret.rotation += rotation_speed * delta
	# elif Input.is_action_pressed("turret_up"):
	# 	turret.rotation -= rotation_speed * delta

	if descending:
		var motion = (800 - position.y) * delta
		translate(Vector2(0, motion))

		# var motion_turret_x = ((turret.position.x + 2) - turret.position.x) * delta
		# var motion_turret_y = ((turret.position.y + 3) - turret.position.y) * delta
		# turret.translate(Vector2(motion_turret_x, motion_turret_y))

		position.y += delta * speed
		if position.y >= 790:
			ship_height = position.y
			landed = true
			descending = false
	elif ascending:
		var motion = -(position.y - 150) * delta
		translate(Vector2(0, motion))

		if position.y <= 250:
			ship_height = position.y
			landed = false
			ascending = false
	else:
		if landed:
			if Input.is_action_just_pressed("fp_forward"):
				hanging = false
				ship_anims.play("ride")
			elif Input.is_action_just_released("fp_forward"):
				ride_stop()
		else:
			if Input.is_action_just_pressed("fp_forward"):
				hanging = false
				engine.play()
				ship_anims.play("start-right")
			elif Input.is_action_just_released("fp_forward"):
				engine_stop()

			if Input.is_action_pressed("fp_down"):
				hanging = false
				position.y += speed * delta / 5
			elif Input.is_action_just_released("fp_down"):
				hanging = true
				ship_height = position.y
					
			if Input.is_action_pressed("fp_up"):
				hanging = false
				position.y -= speed * delta / 5
				ship_height = position.y
			elif Input.is_action_just_released("fp_up"):
				hanging = true
				ship_height = position.y

	if Input.is_action_just_pressed("fp_shoot"):
		if double_shooting:
			double_shoot(delta)
		else:
			shoot(delta)
	if !landed:
		if Input.is_action_just_pressed("fp_drop"):
			hanging = false
			drop()

	if Input.is_action_pressed("fp_transform"):
		if landed:
			ride_stop()
			to_ship_form()
			hanging = true
		elif !landed:
			engine_stop()
			to_truck_form()
			hanging = false

	if hanging:
		position.y += 15 * direction * delta

		if position.y > bottom_bound:
			direction = -1
		elif position.y < top_bound:
			direction = 1
	
# func _integrate_forces(state):
# 	set_applied_force(thrust.rotated(rotation))
# 	set_applied_torque(rotation_dir * spin_thrust * 10)
	
	# var xform = state.get_transform()
	# if xform.origin.x > screensize.x:
	# 	xform.origin.x = 0
	# if xform.origin.x < 0:
	# 	xform.origin.x = screensize.x
	# if xform.origin.y > screensize.y:
	# 	xform.origin.y = 0
	# if xform.origin.y < 0:
	# 	xform.origin.y = screensize.y
	# state.set_transform(xform)

func animation_changed():
	if ship_anims.animation == "start-right":
		ship_anims.play("move-right")
	elif ship_anims.animation == "move-right":
		shifted_2 = true
		ship_anims.play("cruise-right")

func shoot(delta):
	var new_bullet = bullet.instance()
	var turret_angle = turret.rotation
	# print(turret_angle)
	
	var bullet_x = (position.x + 10) + (40 * cos(turret_angle))
	var bullet_y = (position.y + 20) + (40 * sin(turret_angle))
	
	beam.play()
	
	new_bullet.speed = bullet_speed + speed
	new_bullet.angle = turret_angle
	new_bullet.position = Vector2(bullet_x, bullet_y) 
	new_bullet.start_x = bullet_x
	
	get_parent().add_child(new_bullet)
	
func drop():
	var new_drop = drop.instance()
	new_drop.position = Vector2(position.x + 20, position.y + 40) 
	get_parent().add_child(new_drop)
	
func double_shoot(delta):
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
	
	new_bullet_up.angle = turret_angle_up
	new_bullet_up.position = Vector2(bullet_x_up, bullet_y_up) 
	new_bullet_up.speed = bullet_speed + speed
	
	new_bullet_down.angle = turret_angle_down
	new_bullet_down.position = Vector2(bullet_x_up, bullet_y_down) 
	new_bullet_down.speed = bullet_speed + speed
	
	get_parent().add_child(new_bullet_up)
	get_parent().add_child(new_bullet_down)

func set_double_shooting(value):
	if value:
		if double_shooting:
			yield(belt.create_timer(5), "timeout")
			double_shooting = false
		else:
			double_shooting = true
			yield(belt.create_timer(5), "timeout")
			double_shooting = false
	
func engine_stop():
	engine.stop()
	accelerated = false
	wait()

func ride_stop():
	accelerated = false
	ship_anims.play("stop")

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

func wait():
	hanging = true
	ship_anims.play("wait")

func to_truck_form():
	ship_anims.play("transform")
	roll.disabled = false
	descending = true
	
func to_ship_form():
	ship_anims.play("retract-tires")
	roll.disabled = true
	ascending = true

func _on_body_entered(body):
	pass

func drag_this(event):
	if event.is_action_pressed("fp_up") and not dragging:
		dragging = true
		drag_start = get_global_mouse_position()
	
	if event.is_action_pressed("fp_up") and dragging:
		dragging = false
		var drag_end = get_global_mouse_position()
		var dir = drag_start - drag_end
		apply_impulse(Vector2(40, 0), dir * 5)