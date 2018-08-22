extends Node

onready var mountains = $fp_mountains
onready var music = $music

func _ready():
	music.play()
	pass

func _process(delta):
	mountains.mountains_move(delta)

func _on_cartoffel_pressed():
	get_tree().change_scene("res://stages/fp-test.tscn")

func _on_optimus_pressed():
	belt.change_scene("fp-second", "stage")

func _on_tri_pressed():
	print("osman")
	belt.change_scene("fp-tri", "stage")

func _on_watches_pressed():
	get_tree().change_scene("res://stages/fp-fifties.tscn")

func _on_options_pressed():
	pass # replace with function body

func _on_quit_pressed():
	pass # replace with function body