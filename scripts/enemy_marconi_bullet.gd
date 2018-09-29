extends Area2D

export var speed = 100
export var angle = 0
export var damage = 5

var bounced = false
var corrupt_angle = false
var start_x = Vector2()

# signal armor_changed

func _ready():
	randomize()
	corrupt_angle = angle + rand_range(-0.40, +0.40)
	
	connect("body_entered", self, "_on_body_entered")
	
func _process(delta):
	if !bounced:
		rotation = angle
		position.x += cos(angle) * (speed)
		position.y += sin(angle) * (speed)
	else:
		# This is wrong but cool: angle = angle + rand_range(-0.20, +0.20)
		rotation = corrupt_angle
		position.x -= cos(corrupt_angle) * (speed * delta)
		position.y -= sin(corrupt_angle) * (speed * delta)
	
	if position.x < -50:
		queue_free()
	if position.x > start_x + 5000 or position.x < start_x - 5000:
		queue_free()
	
func _on_body_entered(body):
	pass
	# var health_bar = get_tree().get_root().get_node("episode_tries").find_node("health")
	
	if body.is_in_group("player"):
#		# emit_signal("armor_changed", [1])
#		health_bar.frame = body.armor - 1
		body.change_armor(-1)
		queue_free()
	elif body.is_in_group("company"):
		belt.create_explosion(position)
		queue_free()