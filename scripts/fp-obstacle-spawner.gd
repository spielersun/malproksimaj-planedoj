extends Node2D

export(PackedScene) var floating_rock
export(PackedScene) var floating_turret

func _ready():
	while true:
		randomize()
		
		var obstacles = [floating_rock,floating_turret]
		var new_obstacle = belt.choose(obstacles).instance()
		
		new_obstacle.position.x = 2000
		add_child(new_obstacle)
		
		yield(belt.create_timer(rand_range(5.00, 10.00)), "timeout")