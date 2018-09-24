extends Area2D

onready var object = $object

export(PackedScene) var ball

var speed = 100
var health = 10
var dead = false

var top_bound
var bottom_bound
var direction = 1

func _ready():
	randomize()
	object.play("float")
	object.connect("animation_finished", self, "animation_changed")
	
	top_bound = position.y - 10
	bottom_bound = position.y + 10
	
	direction = 1 if rand_range(0,100) > 50 else -1 
	
	$timer.wait_time = rand_range(1.50,3.00)
	
	# yield(belt.create_timer(rand_range(1.50, 3.00)), "timeout")
		
func _process(delta):
	position.x -= delta * speed
	position.y += 10 * direction * delta
	
	if position.y > bottom_bound:
		direction = -1
	elif position.y < top_bound:
		direction = 1

func spawn_balls():
	var new_ball = ball.instance()
	new_ball.position = Vector2(position.x + 10, position.y + 480) 
	get_parent().call_deferred("add_child",new_ball)
	
func bullet_hit(damage):
	health -= damage
	if health <= 0:
		object.play("fall")

func animation_changed():
	if object.animation == "fall":
		queue_free()

func _on_timer_timeout():
	while !dead:
		spawn_balls()
