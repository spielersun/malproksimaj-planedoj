extends "res://scripts/fp-support.gd"

func _ready():
	connect("body_entered", self, "_on_body_entered")
	pass
	
func _on_body_entered(other):
	if other.is_in_group("player"):
		other.double_shooting = true
		queue_free()
