extends RigidBody2D

onready var state = FlappingState.new(self)

func _ready():
	set_process_input(true)
	set_physics_process(true)
	pass
	
func _physics_process(delta):
	state.update(delta)
	pass

func _input(event):
	state.input(event)
	pass

class FlyingState:
	func _init():
		pass
	func update(delta):
		pass
	func input(event):
		pass
	func exit():
		pass

class FlappingState:
	var bird
	
	func _init(bird):
		self.bird = bird
		bird.linear_velocity = Vector2(100, bird.linear_velocity.y)
		pass
		
	func update(delta):
	#	if rad2deg(rotation) > 30:
	#		rotation = deg2rad(30)
	#	angular_velocity = 0
	#	if linear_velocity.y > 0:
	#	angular_velocity = 1.5
		pass
		
	func input(event):
	# 	if event.type != InputEvent.KEY:
	# 	return
	# 	if (event.scancode == KEY_SPACE or event.scancode == KEY_F) and event.is_pressed() and not event.is_echo():
	# 	print("!")
		if event.is_action_pressed("flap"):
			flap()
		pass
		
	func flap():
		bird.linear_velocity = Vector2(bird.linear_velocity.x, -150)
		# angular_velocity = -3
		pass
	
	func exit():
		pass

class HitState:
	func _init():
		pass
	func update(delta):
		pass
	func input(event):
		pass
	func exit():
		pass

class GroundedState:
	func _init():
		pass
	func update(delta):
		pass
	func input(event):
		pass
	func exit():
		pass



