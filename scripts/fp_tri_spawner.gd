extends Node2D

export(PackedScene) var fp_tri_white
export(PackedScene) var fp_tri_red
export(PackedScene) var fp_tri_yellow

var points = 40
var start_x = 350
var start_y = 250 

func _ready():
	randomize()
	
	var pieces = [fp_tri_white,fp_tri_red,fp_tri_yellow]
	var index = 0
	print(position.x)
	
	for point in points:
		var new_piece = belt.choose(pieces).instance()
		
		if index % 10 == 0 and index != 0:
			start_y += 100
			index = 0
			
		new_piece.position.x = start_x + (index*100)
		new_piece.position.y = start_y
		
		add_child(new_piece)
		index += 1

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
