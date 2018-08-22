extends CanvasLayer

const BALANCE_STAGE_GAME = "res://stages/balance_stage.tscn"
const STAGE_MENU = "res://stages/balance_menu.tscn"

var is_changing = false

signal stage_changed

func _ready():
	pass

func change_stage(stage_path):
	# if is_changing:
	# 	return
		
	# is_changing = true
	# get_tree().get_root().set_disable_input(true)
	
	# get_node("anim").play("fade_in")
	# # audio_player.play("swooshing")
	# yield(get_node("anim"), "animation_finished")
	
	# get_tree().change_scene(stage_path)
	# emit_signal("stage_changed")
	
	# get_node("anim").play("fade_out")
	# yield(get_node("anim"), "animation_finished")
	
	# is_changing = false
	# get_tree().get_root().set_disable_input(false)
	pass