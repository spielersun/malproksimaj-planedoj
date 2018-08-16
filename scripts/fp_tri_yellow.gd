extends Area2D

var queue
var rotated
var color
var initiater = false
var x_initiater = false
var y_initiater = false

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
			elif shape_idx == 1:
				if queue < 61:
					position.y += 100
					rotate(deg2rad(180))
					y_initiater = true
			elif shape_idx == 0:
				if queue % 20 != 0:
					
					position.x += 100
					rotate(deg2rad(180))
					x_initiater = true
		else:
			if shape_idx == 2:
				rotate(deg2rad(180))
				initiater = true
			elif shape_idx == 1:
				if queue > 20:
					position.y -= 100
					rotate(deg2rad(180))
					y_initiater = true
			elif shape_idx == 0:
				if (queue-1) % 20 != 0:
					position.x -= 100
					rotate(deg2rad(180))
					x_initiater = true

func _on_area_shape_entered(area_id, area, area_shape, self_shape):
	if area.is_in_group("tri_piece") and area_shape == 2:
		if area.initiater:
			if queue % 2 == 0:
				rotate(deg2rad(180))
				queue -= 1
				area.queue += 1
				area.initiater = false
			else:
				rotate(deg2rad(180))
				queue += 1
				area.queue -= 1
				area.initiater = false
	if area.is_in_group("tri_piece") and area_shape == 1:
		if area.y_initiater:
			if queue % 2 == 0:
				rotate(deg2rad(180))
				queue += 19
				area.queue -= 19
				position.y += 100
				area.y_initiater = false
			else:
				rotate(deg2rad(180))
				queue -= 19
				area.queue += 19
				position.y -= 100
				area.y_initiater = false
	if area.is_in_group("tri_piece") and area_shape == 0:
		if area.x_initiater:
			if queue % 2 == 0:
				rotate(deg2rad(180))
				queue += 1
				area.queue -= 1
				position.x += 100
				area.x_initiater = false
			else:
				rotate(deg2rad(180))
				queue -= 1
				area.queue += 1
				position.x -= 100
				area.x_initiater = false
