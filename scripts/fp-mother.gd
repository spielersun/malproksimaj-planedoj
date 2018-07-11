extends KinematicBody2D

var initial_point_x = 0
var initial_point_y = 0

var on_field = true

signal mother_presence

const supports = [
	preload("res://scenes/fp-support-battery.tscn"),
	preload("res://scenes/fp-support-double.tscn")
]

func _ready():
	yield(create_timer(3), "timeout")
	spawn()
	yield(create_timer(10), "timeout")
	on_field = false
	emit_signal("mother_presence", false)

func spawn():
	while on_field:
		randomize()
		var support = choose(supports).instance()
		var pos = Vector2()
		
		pos.y = position.y + 160
		pos.x = position.x - 220
		
		support.position = pos
		
		get_parent().add_child(support)
		yield(create_timer(rand_range(1, 3)), "timeout")
	
func create_timer(wait_time):
	var timer = Timer.new()
	timer.set_wait_time(wait_time)
	timer.set_one_shot(true)
	timer.connect("timeout", timer, "queue_free")
	add_child(timer)
	timer.start()
	return timer

func choose(choises):
	randomize()
	var rand_index = randi() % choises.size()
	return choises[rand_index]