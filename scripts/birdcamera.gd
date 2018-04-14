extends Camera2D

onready var bird = utils._get_main_node().get_node("bird")

func _ready():
	set_physics_process(true)
	pass

func _physics_process(delta):
	position = Vector2(bird.position.x, position.y)
	pass