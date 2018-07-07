extends Area2D

export var speed = 200
export var damage = 5

export(PackedScene) var explosion

# signal armor_changed

func _ready():
	connect("body_entered", self, "_on_body_entered")
	
func _process(delta):
	_move(delta)
	
	if position.x < -1000:
		queue_free()

func _move(delta):
	position.x -= (speed * delta)
	
func _on_body_entered(area):
	var health_bar = get_tree().get_root().get_node("fp-test").find_node("health")
	
	if area.is_in_group("player"):
		# emit_signal("armor_changed", [1])
		health_bar.frame = area.armor - 1
		area.armor -= 1
		queue_free()

func create_explosion():
	var new_explosion = explosion.instance()
	new_explosion.position = position
	get_parent().add_child(new_explosion)
	