extends Node

onready var camera = $camera

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _physics_process(delta):
	camera.position.x += delta * 100

func _on_start_pressed():
	get_tree().change_scene("res://testerra/episodeOne.tscn")

func _on_options_pressed():
	pass # replace with function body

func _on_exit_pressed():
	get_tree().quit()
