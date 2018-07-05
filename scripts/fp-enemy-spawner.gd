extends Node2D

export(PackedScene) var giorgio
export(PackedScene) var marconi

const enemies = [
	preload("res://scenes/fp-giorgio.tscn"),
	preload("res://scenes/fp-marconi.tscn")
]

func _ready():
	while true:
		randomize()
		
		var position_x = get_viewport_rect().size.x - 100
		var position_y = get_viewport_rect().size.y / 2
		
		var new_enemy = choose(enemies).instance()
		
		new_enemy.position = Vector2(position_x, position_y)
		add_child(new_enemy)
		
		yield(create_timer(rand_range(1.50, 3.00)), "timeout")

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