extends Area2D

export var speed = 200
export var angle = 0
export var damage = 5

var corrupt_angle
var bounced = false

var start_x

export(PackedScene) var explosion

# signal add_score

func _ready():
	randomize()
	corrupt_angle = angle + rand_range(-0.40, +0.40)
	
	connect("body_entered", self, "_on_body_entered")
	connect("area_shape_entered", self, "_on_area_shape_entered")
	
func _process(delta):
	if !bounced:
		rotation = angle
		position.x += cos(angle) * (speed * delta)
		position.y += sin(angle) * (speed * delta)
	else:
		# This is wrong but cool: angle = angle + rand_range(-0.20, +0.20)
		rotation = corrupt_angle
		position.x -= cos(corrupt_angle) * (speed * delta)
		position.y -= sin(corrupt_angle) * (speed * delta)
	
	if position.x > start_x + 5000 or position.x < start_x - 5000:
		queue_free()
	
func _on_body_entered(body):
	var score_text = get_tree().get_root().get_node("episode_tries").find_node("label")
	if body.is_in_group("enemy"):
		body.add_damage(damage)
		belt.create_explosion(position)
		var total_score = int(score_text.text) + 5
		score_text.text = str(total_score)
		# emit_signal("add_score", [5])
		queue_free()
	elif body.is_in_group("company"):
		body.hit_shield()
		queue_free()
		
func _on_area_shape_entered(area_id, area, area_shape, self_shape):
	if area.is_in_group("rock"):
		if area_shape == 0:
			bounced = true
		elif area_shape == 1:
			area.bullet_hit(damage)
			belt.create_explosion(position)
			queue_free()
	elif area.is_in_group("obstacle"):
		area.bullet_hit(damage)
		belt.create_explosion(position)
		queue_free()