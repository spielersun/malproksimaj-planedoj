extends Node

onready var score_text = $"hud/fp-ship-score/score"

var score = 0

func _ready():
	score_text.text = str(score)
	get_node("hud/fp-ship-score/score").connect( "add_score", get_node("fp-cartoffel/fp-cartoffel-bullet"), "change_score" )

func change_score(value):
	score += value
	score_text.text = str(score)
