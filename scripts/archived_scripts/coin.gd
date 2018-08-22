extends Area2D

func _ready():
	connect("body_entered", self, "_on_body_entered")
	pass

func _on_body_entered(other_body):
	if other_body.is_in_group(balance_game.GROUP_BIRDS):
		balance_game.balance_score_current += 1
		audio_player.play("point")
	pass
