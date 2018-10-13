extends Node2D

#const N = 1
#const E = 2
#const S = 4
#const W = 8

const N = 0x1
const E = 0x2
const S = 0x4
const W = 0x8

var cell_walls = {
	Vector2(0,-1): N,
	Vector2(1,0): E,
	Vector2(0,1): S,
	Vector2(-1,0): W
}

#var tile_size = 64
#var width = 25
#var height = 14
#var map_seed = 846847748
#var erase_fraction = 0.2

onready var Map = $tilemap

func _ready():
	$truck.map = Map
	$truck.map_pos = Vector2(0,0)
	$truck.position = Map.map_to_world($truck.map_pos) + Vector2(0,20)

func generate_tile(cell):
	var cells = find_valid_tiles(cell)
	Map.set_cellv(cell, cells[randi() % cells.size()])

func find_valid_tiles(cell):
	var valid_tiles = []
	for i in range(16):
		var is_match = false
		
		for n in cell_walls.keys():
			var neighbor_id = Map.get_cellv(cell+n)
			if neighbor_id >= 0:
				if (neighbor_id & cell_walls[-n])/cell_walls[-n] == (i & cell_walls[n])/cell_walls[-n]:
					is_match = true
				else:
					is_match = false
					break
		if is_match and not i in valid_tiles:
			valid_tiles.append(i)
	return valid_tiles

#func _ready():
#	$camera.zoom = Vector2(3,3)
#	$camera.position = Map.map_to_world(Vector2(width/2, height/2))
#	randomize()
#
#	if !map_seed:
#		map_seed = randi()
#
#	seed(map_seed)
#	print("Seed: ", map_seed)
#	tile_size = Map.cell_size
#
#	make_maze()
#	erase_walls()

#func check_neighbors(cell, unvisited):
#	var list = []
#
#	for n in cell_walls.keys():
#		if cell + n in unvisited:
#			list.append(cell+n)
#
#	return list

#func make_maze():
#	var unvisited = []
#	var stack = []
#
#	Map.clear()
#
#	for x in range(width):
#		for y in range(height):
#			#unvisited.append(Vector2(x,y))
#			Map.set_cellv(Vector2(x,y), N|E|S|W)
#
#	for x in range(0,width,2):
#		for y in range(0,height,2):
#			unvisited.append(Vector2(x,y))
#
#	var current = Vector2(0,0)
#	unvisited.erase(current)
#
#	while unvisited:
#		var neighbors = check_neighbors(current, unvisited)
#
#		if neighbors.size() > 0:
#			var next = neighbors[randi() % neighbors.size()]
#			stack.append(current)
#
#			var dir = next - current
#			var current_walls = Map.get_cellv(current) - cell_walls[dir]
#			var next_walls = Map.get_cellv(next) - cell_walls[-dir]
#
#			Map.set_cellv(current, current_walls)
#			Map.set_cellv(next, next_walls)
#
#			if dir.x != 0:
#				Map.set_cellv(current + dir/2, 5)
#			else:
#				Map.set_cellv(current + dir/2, 10)
#
#			current = next
#			unvisited.erase(current)
#		elif stack:
#			current = stack.pop_back()
#		# yield(get_tree(), 'idle_frame')
		
#func erase_walls():
#	for i in range(int(width*height*erase_fraction)):
#		var x = int(rand_range(2, width/2-2))*2
#		var y = int(rand_range(2, height/2-2))*2
#
#		var cell = Vector2(x, y)
#		var neighbor = cell_walls.keys()[randi()%cell_walls.size()]
#
#		if Map.get_cellv(cell) & cell_walls[neighbor]:
#			var walls = Map.get_cellv(cell) - cell_walls[neighbor]
#			var n_walls = Map.get_cellv(cell + neighbor) - cell_walls[-neighbor]
#
#			Map.set_cellv(cell, walls)
#			Map.set_cellv(cell + neighbor, n_walls)
#
#			if neighbor.x != 0:
#				Map.set_cellv(cell + neighbor/2, 5)
#			else:
#				Map.set_cellv(cell + neighbor/2, 10)
#		yield(get_tree(), 'idle_frame')

	
	
	
	
	
	
	
	
