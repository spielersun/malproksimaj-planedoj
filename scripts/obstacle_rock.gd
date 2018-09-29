extends Area2D

onready var object = $object
export var value = 15

var speed = 100
var health = 10

signal obstacle_destroyed

func _ready():
	object.play("idle")
	object.connect("animation_finished", self, "animation_changed")
	connect("body_shape_entered", self, "_on_body_shape_entered")

func _process(delta):
	# position.x -= delta * speed
	pass
	
func bullet_hit(damage):
	health -= damage
	if health <= 0:
		object.play("fall")

func animation_changed():
	if object.animation == "fall":
		emit_signal("obstacle_destroyed", value)
		queue_free()

func _on_body_shape_entered(body_id, body, body_shape, area_shape):
	var explode_position = Vector2(position.x, position.y+445) 
	
	if body.is_in_group("player"):
		if area_shape == 0:
			bullet_hit(20)
			belt.create_explosion(explode_position)
			body.change_armor(1)
			
		elif area_shape == 1:
			bullet_hit(20)
#			body.change_armor(1)
#			belt.create_explosion(position)
