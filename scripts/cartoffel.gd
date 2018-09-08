extends RigidBody2D

export (int) var engine_thrust
export (int) var spin_thrust

var thrust = Vector2()
var rotation_dir = 0
var screensize

var dragging
var drag_start = Vector2()

func _ready():
	screensize = get_viewport().get_visible_rect().size

func get_input():
	if Input.is_action_pressed("fp_forward"):
		thrust = Vector2(engine_thrust, 0)
	else:
		thrust = Vector2()
	
	if Input.is_action_pressed("fp_auxiliary"):
		apply_impulse(Vector2(0, 0), Vector2(30, 0))
	
	rotation_dir = 0
	
	if Input.is_action_pressed("fp_down"):
		rotation_dir += 1
	if Input.is_action_pressed("fp_up"):
		rotation_dir -= 1

func _process(delta):
	get_input()

func _integrate_forces(state):
	set_applied_force(thrust.rotated(rotation))
	set_applied_torque(rotation_dir * spin_thrust * 10)
	
	# var xform = state.get_transform()
	# if xform.origin.x > screensize.x:
	# 	xform.origin.x = 0
	# if xform.origin.x < 0:
	# 	xform.origin.x = screensize.x
	# if xform.origin.y > screensize.y:
	# 	xform.origin.y = 0
	# if xform.origin.y < 0:
	# 	xform.origin.y = screensize.y
	# state.set_transform(xform)

func drag_this(event):
	if event.is_action_pressed("fp_up") and not dragging:
		dragging = true
		drag_start = get_global_mouse_position()
	
	if event.is_action_pressed("fp_up") and dragging:
		dragging = false
		var drag_end = get_global_mouse_position()
		var dir = drag_start - drag_end
		apply_impulse(Vector2(40, 0), dir * 5)
		












	
