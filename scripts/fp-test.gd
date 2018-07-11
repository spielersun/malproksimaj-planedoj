extends Node2D

onready var mother = $fp_mother

var initial_point_x = 400
var initial_point_y = -200

var release_point_x = 1200
var release_point_y = 0

var back_point_x = 1800
var back_point_y = -200

var mother_on_field = false

var motion_x
var motion_y

func _ready():
	mother_on_field = true
	mother.position.x = initial_point_x
	mother.position.y = initial_point_y
	mother.connect("mother_presence", self, "_on_mother_presence")
	# position.y = clamp(position.y, 0 + 15, view_size.y - 15)
	
func _process(delta):
	if mother_on_field:
		motion_x = (release_point_x - mother.position.x) * delta
		motion_y = (release_point_y - mother.position.y) * delta
		mother.translate(Vector2(motion_x, motion_y))
	else:
		motion_x = (back_point_x - mother.position.x) * delta
		motion_y = (back_point_y - mother.position.y) * delta
		mother.translate(Vector2(motion_x, motion_y))

func _on_mother_presence(value):
	mother_on_field = value