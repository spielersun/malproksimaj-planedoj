extends Node2D

export(PackedScene) var fp_tri_white
export(PackedScene) var fp_tri_red
export(PackedScene) var fp_tri_yellow

var points = 80
var start_x = 350
var start_y = 250 
var piece_angle = false
var piece_queue = 1
var initial_queue = 0

var pos_x = 0
var pos_y = 0

func _ready():
	randomize()
	
	var pieces = [fp_tri_white,fp_tri_red,fp_tri_yellow]
	
	pos_x = start_x
	pos_y = start_y
	
	for point in points:
		var new_piece = belt.choose(pieces).instance()
		
		if piece_queue % 2 == 0:
			new_piece.rotation = deg2rad(180)
			piece_angle = true
		elif piece_queue == 1:
			pass
		else:
			pos_x += 100
			piece_angle = false
		
		if point % 20 == 0 and point != 0:
			pos_x = start_x
			pos_y += 100
		
		new_piece.position.x = pos_x
		new_piece.position.y = pos_y
		
		new_piece.rotated = piece_angle
		new_piece.queue = piece_queue
		add_child(new_piece)
		
		piece_queue += 1

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
