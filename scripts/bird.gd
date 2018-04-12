extends RigidBody2D

func _ready():
	set_process_input(true)
	set_physics_process(true)
	pass
	
func _physics_process(delta):
	if rad2deg(rotation) > 30:
		rotation = deg2rad(30)
	if get_linear_velocity().y > 0:
		set_angular_velocity(1.5)
	pass

func flap():
	set_linear_velocity(Vector2(get_linear_velocity().x, -150))
	set_angular_velocity(-3)
	pass

func _input(event):
	# if event.type != InputEvent.KEY:
	# 	return
	# if (event.scancode == KEY_SPACE or event.scancode == KEY_F) and event.is_pressed() and not event.is_echo():
	# 	print("!")
	if event.is_action_pressed("flap"):
		flap()
	pass
