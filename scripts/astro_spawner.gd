extends Node2D

export(PackedScene) var astro_drop

var east_x = 1800
var east_y = 200

var west_x = -200
var west_y = 500

var north_x =  600
var north_y = -200

var south_x = 700
var south_y = 1100

var drop_count = 50

var spawn_x
var spawn_y

var origin_points = ["east","west","north","south"]

func _ready():
	for drop in drop_count:
		astro_drop()
		randomize()
		yield(belt.create_timer(rand_range(0.50, 1.50)), "timeout")

func astro_drop():
	randomize()
	var new_point = belt.choose(origin_points)
	var new_astro = astro_drop.instance()
	
	spawn_x = rand_range(200, 1400)
	spawn_y = rand_range(200, 700)
	
	if new_point == "east":
		new_astro.origin_pos = "east"
		new_astro.position = Vector2(east_x, spawn_y)
	elif new_point == "west":
		new_astro.origin_pos = "west"
		new_astro.position = Vector2(west_x, spawn_y)
	elif new_point == "north":
		new_astro.origin_pos = "north"
		new_astro.position = Vector2(spawn_x, north_y)
	elif new_point == "south":
		new_astro.origin_pos = "south"
		new_astro.position = Vector2(spawn_x, south_y)
		
	get_parent().add_child(new_astro)
