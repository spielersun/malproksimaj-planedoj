extends Sprite

onready var animation = $animation

var shield_down = false

func _ready():
	if !shield_down:
		get_node("animation").play("fade_out")
		yield(animation, "animation_finished")
		queue_free()

func _process(delta):
	if !shield_down:
		var mother = get_tree().get_root().get_node("episode_cartoffel").find_node("mother")
		position = mother.position