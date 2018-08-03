extends Node2D

export(PackedScene) var wall

var spawner_active = true

var START_POSITION = 1600

func _ready():
	randomize()
	while spawner_active:
		var new_wall = wall.instance()
		new_wall.position.x = START_POSITION
		add_child(new_wall)
		
		yield(belt.create_timer(rand_range(3.50, 5.00)), "timeout")