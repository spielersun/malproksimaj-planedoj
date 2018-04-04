extends Sprite

func _ready():
	## yield(utils.create_timer(1), "timeout")
	
	randomize()
	rotation = deg2rad(rand_range(0,360))
	
	get_node("p_smoke").set_emitting(true)
	get_node("p_flare").set_emitting(true)
	
	get_node("anim").play("fade_out")
	yield(get_node("anim"), "animation_finished")
	queue_free()
	pass
