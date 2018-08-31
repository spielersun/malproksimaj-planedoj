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
	belt.change_scene("fp_tri", "stage")

func _on_watches_pressed():
	get_tree().change_scene("res://stages/fp_fifties.tscn")

func _on_options_pressed():
	pass # replace with function body

func _on_quit_pressed():
	pass # replace with function body

func _on_bathand_pressed():
	belt.change_scene("fp_rubbish", "stage")

func _on_debtruck_pressed():
	belt.change_scene("episode_debtruck", "stage")

func _on_tries_pressed():
	belt.change_scene("episode_tries", "stage")
