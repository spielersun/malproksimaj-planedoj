extends Node

# onready var score_text = $"hud/fp-ship-score/score"
# onready var armor_bar = $"hud/health"

var score = 0

func _ready():
	# score_text.text = str(score)
	# get_node("hud/fp-ship-score/score").connect("add_score", get_node("fp-cartoffel/fp-cartoffel-bullet"), "change_score")
	# get_node("hud/health").connect("armor_changed", get_node("fp-cartoffel"), "change_armor")
	pass

func change_score(value):
	# score += value
	# score_text.text = str(score)
	pass
	
func change_armor(armor):
	# armor_bar.frame = armor
	pass