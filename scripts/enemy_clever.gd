
extends "res://scripts/enemy.gd"

const scn_laser = preload("res://scenes/laser_enemy.tscn")

func _ready():
	velocity.x = utils.choose([velocity.x, velocity.y])
	
	yield(utils.create_timer(1.5), "timeout")
	shoot()
	pass

func _process(delta):
	if position.y <= 0 + 16:
		velocity.y = abs(velocity.y)
	if position.y >= utils.view_size.y - 16:
		velocity.y = -abs(velocity.y)
	pass

func shoot():
	while true:
		var laser = scn_laser.instance()
		laser.position = get_node("cannon").get_position()
		utils.main_node.add_child(laser)
		
		yield(utils.create_timer(1.5), "timeout")
	pass