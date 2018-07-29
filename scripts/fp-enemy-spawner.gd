extends Node2D

export(PackedScene) var giorgio
export(PackedScene) var marconi
export(PackedScene) var lorenna

var lorenna_presence = false

const enemies = [
	preload("res://scenes/fp-giorgio.tscn"),
	preload("res://scenes/fp-marconi.tscn"),
	preload("res://scenes/fp-kendra.tscn"),
	preload("res://scenes/fp-andrew.tscn")
]

func _ready():
	while true:
		randomize()
		
		var position_x = get_viewport_rect().size.x - 100
		var position_y = get_viewport_rect().size.y / 2
		
		var new_enemy = belt.choose(enemies).instance()
		# var new_enemy = enemies[2].instance()
		
		new_enemy.position = Vector2(position_x, position_y)
		add_child(new_enemy)
		
		yield(belt.create_timer(rand_range(3.50, 5.00)), "timeout")
		if !lorenna_presence:
			get_lorenna()

func get_lorenna():
	lorenna_presence = true
	yield(belt.create_timer(rand_range(2, 4)), "timeout")
	var new_grounder = lorenna.instance()
	new_grounder.position.x = 2000
	new_grounder.position.y = 820
	add_child(new_grounder)