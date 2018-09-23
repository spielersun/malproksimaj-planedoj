extends Node2D

onready var lorenna = $enemy_lorenna

var cursor = load("res://sprites/cursor.png")

func _ready():
	pass
	#lorenna.connect("homing_bullet", self, "_on_enemy_lorenna_homing_bullet")

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func _on_exit_pressed():
	belt.change_scene("main_menu", "stage")


func _on_enemy_lorenna_homing_bullet(bullet, position, target_direction, target):
	var new_bullet = bullet.instance()
	add_child(new_bullet)
	new_bullet.start(position, target_direction, target)