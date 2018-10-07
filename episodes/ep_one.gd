extends Node2D

onready var _character = $char
onready var _label = $hud/label
onready var _bar = $hud/xp_bar

func _ready():
	_bar.initialize(_character.experience, _character.experience_required)
	_label.update_text(_character.level, _character.experience, _character.experience_required)

func _input(event):
	if not event.is_action_pressed("ui_accept"):
		return
	_character.gain_experience(50)
	_label.update_text(_character.level, _character.experience, _character.experience_required)