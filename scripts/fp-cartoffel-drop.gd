extends Area2D

onready var item = $item

export var speed = 200
export var angle = 0
export var damage = 20

export(PackedScene) var explosion

func _ready():
	item.play("fall")
	connect("body_entered", self, "_on_body_entered")
	
func _process(delta):
	_move(delta)
	if position.y == 850:
		create_explosion()
		queue_free()

func _move(delta):
	rotation += 0.1
	position.x += -20 * delta
	position.y += 100 * delta
	
func create_explosion():
	var new_explosion = explosion.instance()
	new_explosion.position = position
	get_parent().add_child(new_explosion)
	
func _on_body_entered(area):
	var score_text = get_tree().get_root().get_node("fp-test").find_node("score")
	
	if area.is_in_group("enemy"):
		area.add_damage(damage)
		create_explosion()
		var total_score = int(score_text.text) + 5
		score_text.text = str(total_score)
		queue_free()