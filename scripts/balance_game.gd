extends Node

const GROUP_PIPES = "pipes"
const GROUP_GROUNDS = "grounds"
const GROUP_BIRDS = "birds"

var balance_score_best = 0 setget _set_score_best
var balance_score_current = 0 setget _set_score_current

signal score_best_changed
signal score_current_changed

func _ready():
	pass

func _set_score_best(new_value):
	balance_score_best = new_value
	emit_signal("score_best_changed")
	pass
	
func _set_score_current(new_value):
	balance_score_current = new_value
	emit_signal("score_current_changed")
	pass