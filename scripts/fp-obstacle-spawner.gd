extends Node2D

export(PackedScene) var floating_rock

func _ready():
	var new_obstacle = floating_rock.instance()
	new_obstacle.position.x = 2000
	add_child(new_obstacle)

func create_timer(wait_time):
	var timer = Timer.new()
	timer.set_wait_time(wait_time)
	timer.set_one_shot(true)
	timer.connect("timeout", timer, "queue_free")
	add_child(timer)
	timer.start()
	return timer