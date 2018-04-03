extends Area2D

export var armor = 2 setget set_armor
export var velocity = Vector2()

func _ready():
	set_process(true)
	add_to_group("enemy")
	connect("area_entered", self, "_on_area_entered")
	pass

func _process(delta):
	translate(velocity * delta)
	
	if position.x <= 0: 
		queue_free()
	pass

func _on_area_entered(other):
	if other.is_in_group("ship"):
		other.armor -= 1
		queue_free()
	pass

func set_armor(new_value):
	armor = new_value
	
	if armor <= 0:
		queue_free()
	pass