extends Node2D

const scn_pipe = preload("res://scenes/pipe.tscn")
const GROUND_HEIGHT = 50
const PIPE_WIDTH = 26
const OFFSET_X = 65
const OFFSET_Y = 100
const AMOUNT_TO_FILL_VIEW = 5

func _ready():
	var bird = utils._get_main_node().get_node("bird")
	if bird:
		bird.connect("state_changed", self, "_on_bird_state_changed", [], CONNECT_ONESHOT)
	pass
	
func _on_bird_state_changed(bird):
	if bird.get_state() == bird.STATE_FLAPPING:
		start()
	pass

func start():
	go_init_pos()
	for i in range(AMOUNT_TO_FILL_VIEW):
		spawn_move()
	pass

func go_init_pos():
	randomize()
	var init_pos = Vector2()
	init_pos.x = get_viewport_rect().size.x + PIPE_WIDTH/2	
	init_pos.y = rand_range(0+OFFSET_Y, get_viewport_rect().size.y-GROUND_HEIGHT-OFFSET_Y)
	
	var camera = utils._get_main_node().get_node("birdcamera")
	if camera:
		init_pos.x += camera.get_total_pos().x
	
	position = init_pos
	pass

func spawn_move():
	spawn_pipe()
	go_next_pos()
	pass
	
func spawn_pipe():
	var new_pipe = scn_pipe.instance()
	new_pipe.position = position
	new_pipe.connect("tree_exited", self, "spawn_move")
	get_node("container").add_child(new_pipe)
	pass
	
func go_next_pos():
	randomize()
	var next_pos = position
	next_pos.x += PIPE_WIDTH/2 + OFFSET_X + PIPE_WIDTH/2
	next_pos.y = rand_range(0+OFFSET_Y, get_viewport_rect().size.y-GROUND_HEIGHT-OFFSET_Y)
	position = next_pos
	pass
	
	
	
	
	
	