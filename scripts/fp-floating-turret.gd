extends Area2D

onready var object = $object

export(PackedScene) var ball

var speed = 100
var health = 10
var dead = false

func _ready():
	object.play("float")
	object.connect("animation_finished", self, "animation_changed")
	
	while !dead:
		spawn_balls()
		yield(create_timer(rand_range(1.50, 3.00)), "timeout")
		
func _process(delta):
	position.x -= delta * speed

func spawn_balls():
	var new_ball = ball.instance()
	new_ball.position = Vector2(position.x + 10, position.y + 480) 
	get_parent().add_child(new_ball)

func create_timer(wait_time):
	var timer = Timer.new()
	timer.set_wait_time(wait_time)
	timer.set_one_shot(true)
	timer.connect("timeout", timer, "queue_free")
	add_child(timer)
	timer.start()
	return timer