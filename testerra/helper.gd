extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	pass

func roll_music():
	var bgMusic = AudioStreamPlayer.new()
	self.add_child(bgMusic)
	bgMusic.stream = load("res://assets/sound/awesomeness.wav")
	bgMusic.stream.loop_mode = 1
	bgMusic.play()
	
	
	

