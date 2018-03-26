extends Area2D

func _ready():
	set_process(true)
	pass

func _process(delta):
	var motion = (get_global_mouse_position().y - position.y) * 10 * delta
	translate(Vector2(0, motion))
	
	var view_size = get_viewport_rect().size
	
	position.y = clamp(position.y, 0 + 15, view_size.y - 15)
	pass
