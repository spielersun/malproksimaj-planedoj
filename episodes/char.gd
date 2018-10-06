extends Node

export (int) var max_hp = 12
export (int) var strength = 8
export (int) var magic = 8

export (int) var level = 1

var experience = 0
var experience_total = 0
var experience_required = get_required_experience(level+1)

func _ready():
	pass

func get_required_experience(level):
	return round(pow(level, 1.8) + level*4)

func gain_experience(amount):
	experience_total += amount
	experience += amount
	
	while experience >= experience_required:
		experience -= experience_required
		level_up()

func level_up():
	level += 1
	experience_required = get_required_experience(level + 1)

	var stats = ['max_hp', 'strength', 'magic']
	var random_stat = stats[randi() % stats.size()]
	
	set(random_stat, get(random_stat) + randi() % 4 + 2)
	
	
	
	

		
		
		
		
		
		
		
		
		 