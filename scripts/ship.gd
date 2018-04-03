extends Area2D

var armor = 4 setget set_armor
const scn_laser = preload("res://scenes/laser_ship.tscn")

func _ready():
	set_process(true)
	add_to_group("ship")
	
	yield(utils.create_timer(0.5), "timeout")
	shoot()
	pass

func _process(delta):
	var motion = (get_global_mouse_position().y - position.y) * 10 * delta
	translate(Vector2(0, motion))
	
	var view_size = get_viewport_rect().size
	
	position.y = clamp(position.y, 0 + 15, view_size.y - 15)
	pass

func shoot():
	while true:
		var pos_left = get_node("cannons/left").global_position
		var pos_right = get_node("cannons/right").global_position
		create_laser(pos_left)
		create_laser(pos_right)
		yield(utils.create_timer(0.25), "timeout")
	pass

func set_armor(new_value):
	armor = new_value
	
	if armor <= 0:
		queue_free()
	
func create_laser(pos):
	var laser = scn_laser.instance()
	laser.position = pos
	utils.main_node.add_child(laser)
	pass