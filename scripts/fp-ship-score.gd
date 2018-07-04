extends TextureRect

onready var score_text = $score

var score = 0
var value 

func _ready():
	score_text.text = str(score)
	connect("add_score", self, "change_score", [value])

func change_score(value):
	score += value
	score_text.text = str(score)
	