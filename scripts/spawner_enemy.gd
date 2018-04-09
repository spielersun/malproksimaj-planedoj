extends Node

const enemies = [
	preload("res://scenes/enemy_kamikazee.tscn"),
	preload("res://scenes/enemy_clever.tscn")
]

func _ready():
	# yield(utils.create_timer(2), "timeout")
	spawn()
	pass

func spawn():
	while true:
		randomize()
		var enemy = utils.choose(enemies).instance()
		var pos = Vector2()
		
		pos.y = rand_range(0+16, utils.view_size.y - 16)
		pos.x = 900 + 16
		enemy.position = pos
		
		get_node("container").add_child(enemy)
		yield(utils.create_timer(rand_range(1.50, 3.00)), "timeout")
	pass
