tool
extends TextureProgress

func _ready():
	pass

func initialize(current, maximum):
	max_value = maximum
	value = current
	
func _on_char_experience_gained(growth_data):
	for line in growth_data:
		var target_experience = line[0]
		var max_experience = line[1]
		
		max_value = max_experience
		yield(animate_value(target_experience), "completed")
		
		if abs(max_value-value) < 0.01:
			value = 0

func animate_value(target, tween_duration=1.0):
	$Tween.interpolate_property(self, "value", value, target, tween_duration, Tween.TRANS_SINE, Tween.EASE_OUT)
	$Tween.start()
	yield($Tween, "tween_completed")