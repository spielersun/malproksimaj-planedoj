extends Node2D

export(PackedScene) var fifties_piece

var watch_count = 10
var piece_queue = 1

var start_x = 400
var start_y = 300

var pos_x = 0
var pos_y = 0

func _ready():
	pos_x = start_x
	pos_y = start_y
	
	for watch in watch_count:
		var new_watch = fifties_piece.instance()
		
		if watch % 5 == 0 and watch != 0:
			pos_x = start_x
			pos_y += 200
		elif watch != 0:
			pos_x += 200
			
		new_watch.position.x = pos_x
		new_watch.position.y = pos_y
		
		new_watch.queue = piece_queue
		
		add_child(new_watch)
		
		piece_queue += 1
