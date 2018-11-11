extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _on_start_pressed():
	get_tree().change_scene("res://testerra/episodeOne.tscn")

func _on_options_pressed():
	pass # replace with function body

func _on_exit_pressed():
	get_tree().quit()
