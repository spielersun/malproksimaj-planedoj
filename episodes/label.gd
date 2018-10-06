extends Label

func _ready():
	pass

func update_text(level, experience, required_exp):
	text = """Level: %s
			Experience: %s
			Next Level: %s
			""" % [level, experience, required_exp]

