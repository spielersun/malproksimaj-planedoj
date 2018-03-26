extends Sprite

func _ready():
	get_node("anim").play("fade_out")
	yield(get_node("anim"), "animation_finished")
	queue_free()
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
