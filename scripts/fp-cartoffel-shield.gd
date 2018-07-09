extends Sprite

onready var glare = $glare
onready var anim = $anim

var cartoffel_armor = 5
var shield_down = false

func _ready():
	if !shield_down:
		randomize()
		glare.set_emitting(true)
		get_node("anim").play("fade_out")
	
		yield(anim, "animation_finished")
		queue_free()

func _process(delta):
	if !shield_down:
		var cartoffel = get_tree().get_root().get_node("fp-test").find_node("fp-cartoffel")
		cartoffel_armor = cartoffel.armor
		
		if cartoffel_armor <= 1:
			shield_down = true
			queue_free()
		position = cartoffel.position
	
	