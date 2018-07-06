extends Area2D

export var speed = 200
export var damage = 5

export(PackedScene) var explosion

func _ready():
	connect("body_entered", self, "_on_body_entered")
	
func _process(delta):
	_move(delta)
	
	if position.x < -1000:
		queue_free()

func _move(delta):
	position.x -= (speed * delta)
	
func _on_body_entered(area):
	# var score_text = get_tree().get_root().get_node("fp-test").find_node("score")
	
	if area.is_in_group("player"):
		area.armor -= 1
		queue_free()

func create_explosion():
	var new_explosion = explosion.instance()
	new_explosion.position = position
	get_parent().add_child(new_explosion)
	