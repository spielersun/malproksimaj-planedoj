extends Node2D

const scn_ground = preload("res://scenes/ground.tscn")
const GROUND_WIDTH = 800
const GROUND_HEIGHT = 450
const AMOUNT_TO_FILL_VIEW = 2

func _ready():
	for i in range(AMOUNT_TO_FILL_VIEW):
		spawn_ground()
		go_next_pos()
	pass
	
func spawn_ground():
	var new_ground = scn_ground.instance()
	new_ground.position = Vector2(position.x, GROUND_HEIGHT)
	get_node("container").add_child(new_ground)
	pass

func go_next_pos():
	position = Vector2(position.x + GROUND_WIDTH, position.y)
	pass
