extends Node2D

onready var score = $"hud/score-frame/score"
onready var health = $"hud/health"
onready var astro_spawner = $"astro_spawner"
onready var bathand = $"bathand"

func _ready():
	score.text = "777"
	astro_spawner.connect("took_damage", self, "_on_astro_spawner_took_damage")

func _on_astro_spawner_took_damage(damage):
	var current_health = health.frame
	if (current_health-damage) <= 0:
		bathand.queue_free()
		print("DEATH!")
	else:
		health.frame = current_health - damage

func _on_exit_pressed():
	belt.change_scene("main_menu", "stage")
