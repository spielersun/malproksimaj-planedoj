extends Area2D

onready var item = $item

export var speed = 200
export var angle = 0
export var damage = 20

func _ready():
	item.play("fall")
	connect("body_entered", self, "_on_body_entered")
	
func _process(delta):
	_move(delta)
	if position.y == 850:
		belt.create_explosion(position)
		queue_free()

func _move(delta):
	rotation += 0.1
	position.x += -20 * delta
	position.y += 100 * delta
	
func _on_body_entered(area):
	var score_text = get_tree().get_root().get_node("episode_tries").find_node("label")
	
	if area.is_in_group("enemy"):
		area.add_damage(damage)
		belt.create_explosion(position)
		var total_score = int(score_text.text) + 5
		score_text.text = str(total_score)
		queue_free()