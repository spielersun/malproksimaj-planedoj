extends RichTextLabel

var dialog = ["Hi! This is farplanets.", "Welcome to the dialog trials. Yes, everything is a trial."]
var page = 0

func _ready():
	bbcode_text = dialog[page]
	visible_characters = 0

func _on_timer_timeout():
	visible_characters += 1
	
func _process(delta):
	if Input.is_action_just_pressed("fp_click"):
		if visible_characters > get_total_character_count():
			if page < dialog.size()-1:
				page += 1
				bbcode_text = dialog[page]
				visible_characters = 0
		else:
			visible_characters = get_total_character_count()
