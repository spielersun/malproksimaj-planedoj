extends Area2D

export var speed = 200
export var angle = 0
export var damage = 5
var bounced = false

export(PackedScene) var explosion

# signal add_score

func _ready():
	connect("body_entered", self, "_on_body_entered")
	connect("area_entered", self, "_on_area_entered")
	connect("area_shape_entered", self, "_on_area_shape_entered")
	
func _process(delta):
	if !bounced:
		rotation = angle
		position.x += cos(angle) * (speed * delta)
		position.y += sin(angle) * (speed * delta)
	else:
		rotation = angle
		position.x -= cos(angle) * (speed * delta)
		position.y -= sin(angle) * (speed * delta)
	
	if position.x > 1650 or position.x < 50:
		queue_free()

func _move(delta):
	rotation = angle
	position.x += cos(angle) * (speed * delta)
	position.y += sin(angle) * (speed * delta)
	
func _on_body_entered(body):
	var score_text = get_tree().get_root().get_node("fp-test").find_node("score")
	if body.is_in_group("enemy"):
		body.add_damage(damage)
		create_explosion()
		var total_score = int(score_text.text) + 5
		score_text.text = str(total_score)
		# emit_signal("add_score", [5])
		queue_free()
	elif body.is_in_group("company"):
		body.hit_shield()
		queue_free()
		
func _on_area_entered(area):
	if area.is_in_group("obstacle"):
		area.bullet_hit(damage)
		create_explosion()
		queue_free()
		
func _on_area_shape_entered(area_id, area, area_shape, self_shape):
	if area.is_in_group("rock"):
		if area_shape == 0:
			bounced = true
		elif area_shape == 1:
			area.bullet_hit(damage)
			create_explosion()
			queue_free()
				
func create_explosion():
	var new_explosion = explosion.instance()
	new_explosion.position = position
	get_parent().add_child(new_explosion)
	