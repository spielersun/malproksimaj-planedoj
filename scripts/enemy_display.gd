extends Node2D

var bar_red = preload("res://sprites/enemy/barHorizontal_red_mid 200.png")
var bar_green = preload("res://sprites/enemy/barHorizontal_green_mid 200.png")
var bar_yellow = preload("res://sprites/enemy/barHorizontal_yellow_mid 200.png")

func _ready():
	$health_bar.hide()
		
func _process(delta):
	global_rotation = 0

func update_healthbar(value):
	$health_bar.texture_progress = bar_green
	
	if value < 60:
		$health_bar.texture_progress = bar_yellow
	if value < 25:
		$health_bar.texture_progress = bar_red
	if value < 100:
		$health_bar.show()
	
	$health_bar.value = value
