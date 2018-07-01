extends Node2D

export(PackedScene) var giorgio

func _ready():
	randomize()
	
	var position_x = get_viewport_rect().size.x - 100
	var position_y = get_viewport_rect().size.y / 2
	var new_giorgio = giorgio.instance()
	
	new_giorgio.position = Vector2(position_x, position_y)
	add_child(new_giorgio)
