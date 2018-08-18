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
var color

var red_count = 0
var white_count = 0
var yellow_count = 0

var red_limit = 20
var white_limit = 40
var yellow_limit = 20

var pos_x = 0
var pos_y = 0

var correct = [
	"white", "white", "white", "white","white","white", "white", "white", "white","white",
	"white", "white", "white", "white","white","white", "white", "white", "white","white",
	"red", "red", "red", "red","red","red", "red", "red", "red","red",
	"yellow", "yellow", "yellow", "yellow","yellow","yellow", "yellow", "yellow", "yellow","yellow",
	"yellow", "yellow", "yellow", "yellow","yellow","yellow", "yellow", "yellow", "yellow","yellow",
	"red", "red", "red", "red","red","red", "red", "red", "red","red",
	"white", "white", "white", "white","white","white", "white", "white", "white","white",
	"white", "white", "white", "white","white","white", "white", "white", "white","white",
]

var current = [
	"red", "red", "red", "red","red","red", "red", "red", "red","red",
	"red", "red", "red", "red","red","red", "red", "red", "red","red",
	"red", "red", "red", "red","red","red", "red", "red", "red","red",
	"red", "red", "red", "red","red","red", "red", "red", "red","red",
	"red", "red", "red", "red","red","red", "red", "red", "red","red",
	"red", "red", "red", "red","red","red", "red", "red", "red","red",
	"red", "red", "red", "red","red","red", "red", "red", "red","red",
	"red", "red", "red", "red","red","red", "red", "red", "red","red"
]

func _ready():
	randomize()
	
	var pieces = [fp_tri_red,fp_tri_yellow,fp_tri_white]
	
	pos_x = start_x
	pos_y = start_y
	
	for point in points:
		var new_piece_index = randi() % pieces.size()
		
		if new_piece_index == 0 and red_count == red_limit:
			new_piece_index = 1
			if yellow_count == yellow_limit:
				new_piece_index = 2
			
		if new_piece_index == 1 and yellow_count == yellow_limit:
			new_piece_index = 2
			if white_count == white_limit:
				new_piece_index = 0
				
		if new_piece_index == 2 and white_count == white_limit:
			new_piece_index = 0
			if red_count == red_limit:
				new_piece_index = 1
		
		if new_piece_index == 0:
			color = "red"
			red_count += 1
		elif new_piece_index == 1:
			color = "yellow"
			yellow_count += 1
		elif new_piece_index == 2:
			color = "white"
			white_count += 1
			
		var new_piece = pieces[new_piece_index].instance()
		
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
		
		current[(piece_queue-1)] = color
		new_piece.connect("pin_piece", self, "_on_pin_piece")
		
		add_child(new_piece)
		
		piece_queue += 1

func _on_pin_piece(piece_queue, piece_color):
	current[(int(piece_queue) - 1)] = piece_color
	if current == correct:
		print("YES")