extends Node

const GROUP_PIPES = "pipes"
const GROUP_GROUNDS = "grounds"
const GROUP_BIRDS = "birds"

const MEDAL_BRONZE = 10
const MEDAL_SILVER = 20
const MEDAL_GOLD = 30
const MEDAL_PLATINUM = 40

var balance_score_best = 0 setget _set_score_best
var balance_score_current = 0 setget _set_score_current

signal score_best_changed
signal score_current_changed

func _ready():
	# balance_stage_manager.connect("stage_changed", self, "_on_stage_changed")
	pass

func _on_stage_changed():
	# balance_score_current = 0
	pass

func _set_score_best(new_value):
	# if new_value > balance_score_best:
	# 	balance_score_best = new_value
	# 	emit_signal("score_best_changed")
	pass
	
func _set_score_current(new_value):
	# balance_score_current = new_value
	# emit_signal("score_current_changed")
	pass