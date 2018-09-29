extends Node2D

onready var score = $hud/score/label
onready var health = $hud/health

var cursor = load("res://sprites/cursor.png")

func _ready():
	pass
	#lorenna.connect("homing_bullet", self, "_on_enemy_lorenna_homing_bullet")

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func _on_exit_pressed():
	belt.change_scene("main_menu", "stage")

func _on_enemy_lorenna_homing_bullet(bullet, position, target_direction, target):
	var new_bullet = bullet.instance()
	add_child(new_bullet)
	new_bullet.start(position, target_direction, target)

func _on_enemy_dead(value):
	var total_score = int(score.text) + value
	score.text = str(total_score)

func _on_obstacle_destroyed(value):
	var total_score = int(score.text) + value
	score.text = str(total_score)

func _on_cartoffel_armor_changed(value):
	health.frame += value
