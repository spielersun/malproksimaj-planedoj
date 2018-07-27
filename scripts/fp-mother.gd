extends KinematicBody2D

export(PackedScene) var shield

var initial_point_x = 400
var initial_point_y = -200

var release_point_x = 1200
var release_point_y = 0

var back_point_x = 1800
var back_point_y = -200

var mother_on_field = false
var on_field = true
var supports_count = 0

var motion_x
var motion_y

const supports = [
	preload("res://scenes/fp-support-battery.tscn"),
	preload("res://scenes/fp-support-double.tscn")
]

func _ready():
	while true:
		came_to_help()
		spawn_supports()
		yield(belt.create_timer(10), "timeout")

func spawn_supports():
	randomize()
	supports_count = rand_range(5, 10)
	if on_field:
		for s in supports_count:
			var support = choose(supports).instance()
			var pos = Vector2()
			
			pos.y = position.y + 160
			pos.x = position.x - 220
			
			support.position = pos
			
			get_parent().add_child(support)
			yield(belt.create_timer(rand_range(2, 4)), "timeout")
		on_field = false

func choose(choises):
	randomize()
	var rand_index = randi() % choises.size()
	return choises[rand_index]


func came_to_help():
	yield(belt.create_timer(5), "timeout")
	position.x = initial_point_x
	position.y = initial_point_y
	on_field = true
	
func _process(delta):
	if on_field:
		motion_x = (release_point_x - position.x) * delta
		motion_y = (release_point_y - position.y) * delta
		translate(Vector2(motion_x, motion_y))
	else:
		motion_x = (back_point_x - position.x) * delta
		motion_y = (back_point_y - position.y) * delta
		translate(Vector2(motion_x, motion_y))
	
func hit_shield():
	var new_hit = shield.instance()
	new_hit.position = position
	get_parent().add_child(new_hit)