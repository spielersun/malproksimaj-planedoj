extends Sprite

export var velocity = Vector2()

func _ready():
	set_process(true)
	pass

func _process(delta):
	translate(velocity * delta)
	
	var view_size = get_viewport_rect().size
	
	if position.x <= -450:
		position = Vector2(800,0)
	pass
