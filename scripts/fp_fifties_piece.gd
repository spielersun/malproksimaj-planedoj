extends Area2D

onready var outer = $watch_outer
onready var middle = $watch_middle
onready var inner = $watch_inner

var queue

func _ready():
	pass

func _on_fp_fifties_piece_input_event(viewport, event, shape_idx):
	print(queue)
	if Input.is_action_just_pressed("fp_backwards"):
		outer.rotate(0.2)
	elif Input.is_action_just_pressed("fp_down"):
		middle.rotate(0.2)
	elif Input.is_action_just_pressed("fp_forward"):
		inner.rotate(0.2)
