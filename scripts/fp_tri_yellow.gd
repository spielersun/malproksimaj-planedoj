extends StaticBody2D

func _ready():
    pass

func _process(delta):
    pass
	
func _on_fp_tri_yellow_input_event(viewport, event, shape_idx):
	if event.is_pressed():
		print("Found Yellow")
