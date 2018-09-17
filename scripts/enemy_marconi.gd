extends KinematicBody2D

export (int) var detect_radius
export (float) var fire_rate

export var speed = 100
export var health = 15

export(PackedScene) var bullet

onready var sprite = $sprite
onready var collision = $shape

var target
var can_shoot = true

var target_pos
var left_bound
var right_bound

var direction = 1
var dead = false
var hit_pos
var vis_color = Color(.867, .91, .247, .1)
var laser_color = Color(1.0, .329, .298)

signal marconi_defeated

func _ready():
	randomize()
	
	left_bound = position.y - 100
	right_bound = position.y + 100
	direction = 1 if rand_range(0,100) > 50 else -1 
	
#	while !dead:
#		shoot()
#		randomize()
#		yield(belt.create_timer(rand_range(1.50, 3.00)), "timeout")
	
	var extra_shape = CircleShape2D.new()
	extra_shape.radius = detect_radius
	$vision/shape.shape = extra_shape
	$timer.wait_time = fire_rate

func _physics_process(delta):
	update()
	if target:
		aim()

func aim():
	hit_pos = []
	
	var space_state = get_world_2d().direct_space_state
	#var target_extents = target.get_node('shape').shape.extents - Vector2(5,5)
	var nw = target.position - Vector2(50,50)
	var se = target.position + Vector2(50,50)
	var ne = target.position + Vector2(50,-50)
	var sw = target.position + Vector2(-50,50)
	
	for pos in [target.position, nw, ne, se, sw]:
		var result = space_state.intersect_ray(position, pos, [self], collision_mask)
		if result:
			hit_pos.append(result.position)
			if result.collider.name == "cartoffel":
				sprite.play("active")
				rotation = (target.position - position).angle()
				if can_shoot:
					shoot(pos)
				break

#func _process(delta):
	#movement(delta)
	#position.y += speed * direction * delta
	
	#if position.y > right_bound:
	#	direction = -1
	#elif position.y < left_bound:
	#	direction = 1
	
	#if position.x < -100:
	#	queue_free()

#func movement(delta):
#	position.x -= speed/2 * delta

func add_damage(damage):
	health -= damage
	if health <= 0:
		dead = true
		queue_free()
		hide()
		emit_signal("marconi_defeated")

func shoot(pos):
	randomize()
	var new_bullet = bullet.instance()
	var bullet_rotation = (pos - global_position).angle()
	
	var bullet_x = position.x
	var bullet_y = position.y
	
	new_bullet.speed = speed/10
	new_bullet.angle = bullet_rotation + rand_range(-0.1, 0.1)
	new_bullet.position = Vector2(bullet_x, bullet_y) 
	new_bullet.start_x = bullet_x
	
	get_parent().add_child(new_bullet)
	can_shoot = false
	$timer.start()

func _draw():
	draw_circle(Vector2(), detect_radius, vis_color)
	if target:
		for hit in hit_pos:
			draw_circle((hit - position).rotated(-rotation), 5, laser_color)
			draw_line(Vector2(), (hit - position).rotated(-rotation), laser_color)

func _on_vision_body_entered(body):
	if body.is_in_group("player"):
		if target:
			return
		target = body
	
func _on_vision_body_exited(body):
	if body.is_in_group("player"):
		if body == target:
			target = null
			sprite.stop()

func _on_timer_timeout():
	can_shoot = true
