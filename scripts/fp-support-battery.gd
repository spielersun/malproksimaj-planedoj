extends "res://scripts/fp-support.gd"

func _ready():
	connect("body_entered", self, "_on_body_entered")
	pass
	
func _on_body_entered(other):
	var health_bar = get_tree().get_root().get_node("fp-test").find_node("health")
	if other.is_in_group("player"):
		health_bar.frame = other.armor + 1
		other.armor += 1
		queue_free()
