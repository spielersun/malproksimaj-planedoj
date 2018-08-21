extends Area2D

onready var outer = $watch_outer
onready var middle = $watch_middle
onready var inner = $watch_inner

onready var outer_anim = $watch_outer/outer_anim
onready var middle_anim = $watch_middle/middle_anim
onready var inner_anim = $watch_inner/inner_anim

var queue
var current_piece = false
var rotate_constant = deg2rad(45)

var inner_position = 0
var middle_position = 0
var outer_position = 0

var watch_limit = 8

var mouse_x
var mouse_y

var pos_x
var pos_y

func _ready():
	pos_x = position.x
	pos_y = position.y
	
func _process(delta):
	mouse_x = get_global_mouse_position().x
	mouse_y = get_global_mouse_position().y
	
	if square_collision(mouse_x, mouse_y, pos_x-50, pos_x+50, pos_y-50, pos_y+50):
		current_piece = true
	else:
		current_piece = false
	
	if current_piece:
		if Input.is_action_just_pressed("fp_backwards"):
			if outer_position != watch_limit:
				outer_anim.play("rotate_" + str(outer_position+1))
				outer_position += 1
			else:
				outer_anim.play("rotate_1")
				outer_position = 1
		elif Input.is_action_just_pressed("fp_down"):
			if middle_position != watch_limit:
				middle_anim.play("rotate_" + str(middle_position+1))
				middle_position += 1
			else:
				middle_anim.play("rotate_1")
				middle_position = 1
		elif Input.is_action_just_pressed("fp_forward"):
			if inner_position != watch_limit:
				inner_anim.play("rotate_" + str(inner_position+1))
				inner_position += 1
			else:
				inner_anim.play("rotate_1")
				inner_position = 1

func _on_fp_fifties_piece_input_event(viewport, event, shape_idx):
	pass

func square_collision(object_x, object_y, width_x, width_x_delta, height_y, height_y_delta):
	if object_x > width_x and object_x < width_x_delta and object_y > height_y and object_y < height_y_delta:
		return true