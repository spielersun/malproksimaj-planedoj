extends Node2D

export(PackedScene) var astro_drop

var east_x = 1800
var east_y = 200

var west_x= -200
var west_y = 500

var drop_count = 5

var origin_points = ["east","west"]

func _ready():
	for drop in drop_count:
		astro_drop()
		randomize()
		yield(belt.create_timer(rand_range(1.50, 3.00)), "timeout")

func astro_drop():
	randomize()
	var new_point = belt.choose(origin_points)
	
	var new_astro = astro_drop.instance()
	
	if new_point == "east":
		new_astro.origin_pos = "east"
		new_astro.position = Vector2(east_x, east_y)
	elif new_point == "west":
		new_astro.origin_pos = "west"
		new_astro.position = Vector2(west_x, west_y)
		
	get_parent().add_child(new_astro)
