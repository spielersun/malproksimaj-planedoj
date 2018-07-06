extends Area2D

export var speed = 200
export var angle = 0
export var damage = 5

export(PackedScene) var explosion

signal add_score

func _ready():
	connect("body_entered", self, "_on_body_entered")
	
func _process(delta):
	_move(delta)
	
	if position.x > 3000:
		queue_free()

func _move(delta):
	rotation = angle
	position.x += cos(angle) * (speed * delta)
	position.y += sin(angle) * (speed * delta)
	
func _on_body_entered(area):
	var score_text = get_tree().get_root().get_node("fp-test").find_node("score")
	
	if area.is_in_group("enemy"):
		area.add_damage(damage)
		create_explosion()
		var total_score = int(score_text.text) + 5
		score_text.text = str(total_score)
		emit_signal("add_score", [5])
		queue_free()

func create_explosion():
	var new_explosion = explosion.instance()
	new_explosion.position = position
	get_parent().add_child(new_explosion)
	