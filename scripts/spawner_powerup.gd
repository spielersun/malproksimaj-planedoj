extends Node

const powerups = [
	preload("res://scenes/powerup_armor.tscn"),
	preload("res://scenes/powerup_laser.tscn")
]

func _ready():
	yield(utils.create_timer(rand_range(10, 15)), "timeout")
	spawn()

func spawn():
	while true:
		randomize()
		var powerup = utils.choose(powerups).instance()
		var pos = Vector2()
		
		pos.y = rand_range(0+7, utils.view_size.y - 7)
		pos.x = 900 + 7
		powerup.position = pos
		
		get_node("container").add_child(powerup)
		yield(utils.create_timer(rand_range(10, 15)), "timeout")