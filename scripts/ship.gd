extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	set_process(true)
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _process(delta):
	var motion = (get_global_mouse_position().y - position.y) * 10 * delta
	translate(Vector2(0, motion))
	
	var view_size = get_viewport().size
	
	position.y = clamp(position.y, 0 + 30, view_size.y - 30)
	pass
