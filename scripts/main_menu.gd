extends Node

onready var mountains = $fp_mountains
onready var music = $music

func _ready():
	music.play()
	pass

func _process(delta):
	mountains.mountains_move(delta)

#get_tree().change_scene("res://stages/fp_fifties.tscn")

func _on_cartoffel_pressed():
	belt.change_scene("episode_cartoffel", "stage")

func _on_optimus_pressed():
	belt.change_scene("episode_optimus", "stage")

func _on_tri_pressed():
	belt.change_scene("episode_tri", "stage")

func _on_bathand_pressed():
	belt.change_scene("episode_rubbish", "stage")
	
func _on_watches_pressed():
	belt.change_scene("episode_watches", "stage")

func _on_debtruck_pressed():
	belt.change_scene("episode_debtruck", "stage")

func _on_tries_pressed():
	belt.change_scene("episode_tries", "stage")
	
func _on_puzzle_pressed():
	belt.change_scene("episode_puzzle", "stage")
	
func _on_options_pressed():
	pass # replace with function body

func _on_quit_pressed():
	pass # replace with function body
