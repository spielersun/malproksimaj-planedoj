extends Node2D

func _ready():
	pass

func _on_exit_pressed():
	belt.change_scene("main_menu", "stage")
