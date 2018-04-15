extends RigidBody2D

func _ready():
	linear_velocity = Vector2(150, linear_velocity.y)
	set_process_input(true)
	set_physics_process(true)
	pass
	
func _physics_process(delta):
	if rad2deg(rotation) > 30:
		rotation = deg2rad(30)
	#	angular_velocity = 0
		
	#if linear_velocity.y > 0:
	#	angular_velocity = 1.5
	pass


func flap():
	linear_velocity = Vector2(linear_velocity.x, -150)
	# angular_velocity = -3
	pass

func _input(event):
	# if event.type != InputEvent.KEY:
	# 	return
	# if (event.scancode == KEY_SPACE or event.scancode == KEY_F) and event.is_pressed() and not event.is_echo():
	# 	print("!")
	if event.is_action_pressed("flap"):
		flap()
	pass
