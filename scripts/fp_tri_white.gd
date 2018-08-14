extends StaticBody2D

var queue
var rotated

func _ready():
    pass

func _process(delta):
    pass
        
func _on_fp_tri_white_input_event(viewport, event, shape_idx):
	if event.is_pressed():
		print(queue)
		print(shape_idx)
		# rotate(deg2rad(180))
