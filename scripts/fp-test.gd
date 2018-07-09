extends Node2D

onready var mother = $fp_mother

var initial_point_x = 400
var initial_point_y = -200

var release_point_x = 1200
var release_point_y = 0

func _ready():
	mother.position.x = initial_point_x
	mother.position.y = initial_point_y
	
	# position.y = clamp(position.y, 0 + 15, view_size.y - 15)
	
func _process(delta):
	var motion_x = (release_point_x - mother.position.x) * delta
	var motion_y = (release_point_y - mother.position.y) * delta
	
	mother.translate(Vector2(motion_x, motion_y))