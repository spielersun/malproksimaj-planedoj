extends Sprite

onready var glare = $glare
onready var anim = $anim

func _ready():
	randomize()
	
	glare.set_emitting(true)
	
	get_node("anim").play("fade_out")
	yield(anim, "animation_finished")
	queue_free()

func _process(delta):
	var cartoffel = get_tree().get_root().get_node("fp-test").find_node("fp-cartoffel")
	position = cartoffel.position