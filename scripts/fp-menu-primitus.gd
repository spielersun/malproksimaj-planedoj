extends Node

onready var mountains = $fp_mountains
onready var music = $music

func _ready():
	music.play()
	pass

func _process(delta):
	mountains.mountains_move(delta)
	pass


func _on_start_pressed():
	get_tree().change_scene("res://stages/fp-test.tscn")


func _on_options_pressed():
	pass # replace with function body


func _on_quit_pressed():
	pass # replace with function body
