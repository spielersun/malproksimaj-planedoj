extends Area2D

onready var sprite = $sprite

export (float) var steer_force
export (float) var speed
export (float) var damage

var velocity = Vector2()
var acceleration = Vector2()
var target = null
var start_x

func start(_position, _direction, _target=null):
	position = _position
	rotation = _direction.angle()
	velocity = _direction * speed
	target = _target
	
func _ready():
	sprite.play("fall")
	connect("body_entered", self, "_on_body_entered")
	start_x = position.x

func seek():
	var desired = (target.position - position).normalized() * speed
	var steer = (desired - velocity).normalized() * steer_force
	return steer

func _process(delta):
	if target:
		acceleration += seek()
		velocity += acceleration * delta
		velocity = velocity.clamped(speed)
		rotation = velocity.angle()
	#rotation += 0.1
	position += velocity * delta
	#position.y += 100 * delta
	
	if position.x < start_x - 2000 or position.x > start_x + 2000:
		belt.create_explosion(position)
		queue_free()

func _on_body_entered(area):
	var score_text = get_tree().get_root().get_node("episode_tries").find_node("label")
	
#	if area.is_in_group("enemy"):
#		area.add_damage(damage)
#		belt.create_explosion(position)
#		var total_score = int(score_text.text) + 5
#		score_text.text = str(total_score)
#		queue_free()