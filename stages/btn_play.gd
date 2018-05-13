extends TextureButton

func _ready():
	connect("pressed", self, "_on_pressed")
	pass

func _on_pressed():
	balance_stage_manager.change_stage(balance_stage_manager.BALANCE_STAGE_GAME)
	pass