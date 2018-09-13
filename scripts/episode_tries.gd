extends Node2D

var cursor = load("res://sprites/cursor.png")

func _ready():
	# Input.set_custom_mouse_cursor(cursor)
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func _on_exit_pressed():
	belt.change_scene("main_menu", "stage")
