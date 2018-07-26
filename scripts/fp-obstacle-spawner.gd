extends Node2D

export(PackedScene) var floating_rock
export(PackedScene) var floating_turret


	
func _ready():
	while true:
		randomize()
		
		var obstacles = [
			floating_rock,
			floating_turret
		]
		
		var new_obstacle = choose(obstacles).instance()
		new_obstacle.position.x = 2000
		add_child(new_obstacle)
		
		yield(create_timer(rand_range(5.00, 10.00)), "timeout")

func choose(choises):
	randomize()
	var rand_index = randi() % choises.size()
	return choises[rand_index]
	
func create_timer(wait_time):
	var timer = Timer.new()
	timer.set_wait_time(wait_time)
	timer.set_one_shot(true)
	timer.connect("timeout", timer, "queue_free")
	add_child(timer)
	timer.start()
	return timer