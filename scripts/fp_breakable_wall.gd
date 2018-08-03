extends Area2D

onready var left_wall = $left_wall
onready var right_wall = $right_wall

var score_text
var new_score
var effect_input

onready var effect = $effect/effect_rect/effect_label

func _ready():
	randomize()
	
	effect_input = int(rand_range(-5,5))
	effect.text = str(effect_input)
	
	connect("body_entered", self, "_on_body_entered")
	right_wall.connect("animation_finished", self, "animation_changed")
	
func _process(delta):
	position.x -= delta * 100
	
	if position.x <= -50:
		queue_free()
		
func animation_changed():
	if right_wall.animation == "shatter":
		queue_free()
		
func _on_body_entered(area):
	score_text = get_tree().get_root().get_node("fp-second").find_node("score_label")
	
	if area.is_in_group("player"):
		left_wall.play("shatter")
		right_wall.play("shatter")