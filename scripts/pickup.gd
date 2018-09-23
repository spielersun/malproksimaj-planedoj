extends Area2D

enum Items {health, ammo}

export (Items) var type = Items.health
export (Vector2) var amount = Vector2(10, 25)

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_pickup_body_entered(body):
	match type:
		Items.health:
			if body.has_method('heal'):
				body.heal(int(rand_range(amount.x, amount.y)))
		Items.ammo:
			pass
	queue_free()
