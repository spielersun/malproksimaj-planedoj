extends StaticBody2D

onready var bottom_right = get_node("bottom_right")
onready var camera = utils._get_main_node().get_node("birdcamera")

signal destroyed

func _ready():
	set_process(true)
	add_to_group(balance_game.GROUP_GROUNDS)
	pass

func _process(delta):
	if camera == null: 
		return
	
	if position.x + 1300 <= camera.get_total_pos().x:
		queue_free()
		emit_signal("destroyed")
	pass