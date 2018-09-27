extends RigidBody2D

onready var ship_anims = $object

var dead = false

var top_bound
var bottom_bound
var direction = 1
var hanging = false
var entering = false

var entering_speed = 0

var new_x = 400
var new_y = 550

func _ready():
	randomize()

	top_bound = new_y - 2
	bottom_bound = new_y + 2
	
	direction = 1 if rand_range(0,100) > 50 else -1 
	
	connect("body_entered", self, "_on_body_entered")
	connect("body_shape_entered", self, "_on_body_shape_entered")

func _physics_process(delta):
	
	if Input.is_action_pressed("fp_auxiliary"):
		ship_anims.play("enter")
		entering = true
		
	if hanging:
		position.y += 7 * direction * delta
	
		if position.y > bottom_bound:
			direction = -1
		elif position.y < top_bound:
			direction = 1
	
	if entering:
		var motion = -(position.y - new_y) * delta
		translate(Vector2(0, motion))
		
		if position.y >= new_y - 10:
			entering = false
			ship_anims.play("active")
			hanging = true

func _on_body_entered(body):
	if body.is_in_group("enemy"):
		body.detonate()

func hit_shield():
	pass

func _on_body_shape_entered(body_id, body, body_shape, local_shape):
	print(body)
	print(local_shape)
	print(body_shape)


