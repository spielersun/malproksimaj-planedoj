extends KinematicBody2D

export (int) var detect_radius
export (float) var fire_rate

export(PackedScene) var bullet

export var speed = 100
export var health = 1000

onready var sprite = $vehicle
onready var collision = $shape

var target
var can_shoot = true
var start_x

var target_pos
var left_bound
var right_bound

var direction = 1
var dead = false
var hit_pos
var vis_color = Color(.867, .91, .247, .1)
var laser_color = Color(1.0, .329, .298)

signal homing_bullet
signal enemy_dead

func _ready():
	start_x = position.x
	
	var extra_shape = CircleShape2D.new()
	extra_shape.radius = detect_radius
	$vision/shape.shape = extra_shape
	$timer.wait_time = fire_rate

func _physics_process(delta):
	position.x -= speed * delta
	sprite.play("move-left")
	update()
	
	if target:
		aim()
		
	if position.x < start_x - 3000:
		queue_free()
		
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
				rotation = (target.position - position).angle()
				if can_shoot:
					shoot(pos)
				break

func add_damage(damage):
	health -= damage
	if health <= 0:
		dead = true
		emit_signal("enemy_dead", "kendra")
		queue_free()

func shoot(pos):
	randomize()
	#var new_bullet = bullet.instance()
	var target_direction = pos - global_position
	var bullet_rotation = target_direction.angle()
	
	emit_signal('homing_bullet', bullet, position, target_direction, target)
	#get_parent().add_child(new_bullet)
	#new_bullet.start()
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

func _on_timer_timeout():
	can_shoot = true