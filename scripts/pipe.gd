extends StaticBody2D

onready var camera = utils._get_main_node().get_node("birdcamera")

func _ready():
	set_process(true)
	pass

func _process(delta):
	if camera == null: 
		return
	
	if position.x + 1300 <= camera.get_total_pos().x:
		queue_free()
	pass

