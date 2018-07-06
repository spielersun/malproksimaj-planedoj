extends Sprite

onready var p_smoke = $p_smoke
onready var p_flare = $p_flare
onready var anim = $anim

func _ready():
	randomize()
	rotation = deg2rad(rand_range(0,360))
	
	p_smoke.set_emitting(true)
	p_flare.set_emitting(true)
	
	get_node("anim").play("fade_out")
	yield(anim, "animation_finished")
	queue_free()
