extends Node2D

export(PackedScene) var astro_drop
export(PackedScene) var astro_drop_prize

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

signal took_damage

func _ready():
	for drop in drop_count:
		if drop != (drop_count-1):
			astro_drop()
			randomize()
			yield(belt.create_timer(rand_range(0.15, 0.75)), "timeout")
		else:
			astro_drop_prize()

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
	
	new_astro.connect("astro_crashed", self, "_on_astro_crashed")
	get_parent().add_child(new_astro)


func astro_drop_prize():
	randomize()
	var new_point = belt.choose(origin_points)
	var new_astro = astro_drop_prize.instance()
	
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
	
	new_astro.connect("astro_crashed", self, "_on_astro_crashed")
	get_parent().add_child(new_astro)

func _on_astro_crashed(damage):
	emit_signal("took_damage", damage)