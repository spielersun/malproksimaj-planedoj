extends Area2D

var queue
var rotated
var color
var initiater = false

func _ready():
	color = "yellow"
	connect("area_shape_entered", self, "_on_area_shape_entered")

func _process(delta):
    pass
	
func _on_fp_tri_yellow_input_event(viewport, event, shape_idx):
	print(queue)
	if event.is_pressed():
		if queue % 2 == 0:
			if shape_idx == 2:
				rotate(deg2rad(180))
				initiater = true
		else:
			if shape_idx == 2:
				rotate(deg2rad(180))
				initiater = true

func _on_area_shape_entered(area_id, area, area_shape, self_shape):
	if area.is_in_group("tri_piece") and area_shape == 2:
		if !initiater:
			if queue % 2 == 0:
				rotate(deg2rad(180))
				queue -= 1
				area.queue += 1
			else:
				rotate(deg2rad(180))
				queue += 1
				area.queue -= 1
		else:
			initiater = false
