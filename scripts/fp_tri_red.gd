extends StaticBody2D

var queue
var rotated

func _ready():
    pass

func _process(delta):
    pass

func _on_fp_tri_red_input_event(viewport, event, shape_idx):
	if event.is_pressed():
		print(queue)
		print(shape_idx)
