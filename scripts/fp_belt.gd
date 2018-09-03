extends Node

var main_node setget , _get_main_node
var view_size setget , _get_view_size
var mouse_pos setget , _get_mouse_pos

const explosion = preload("res://scenes/fp-enemy-explosion.tscn")

const SCENE_PATH = "res://scenes/"
const STAGE_PATH = "res://stages/"

func _ready():
	pass

func create_timer(wait_time):
	var timer = Timer.new()
	timer.set_wait_time(wait_time)
	timer.set_one_shot(true)
	timer.connect("timeout", timer, "queue_free")
	add_child(timer)
	timer.start()
	return timer

func choose(choises):
	randomize()
	var rand_index = randi() % choises.size()
	return choises[rand_index]

func find_node(node):
	return self.main_node.find_node(node)

func attach(src_node, src_signal, trg_node, trg_func):
	if typeof(src_node) == TYPE_STRING:
		src_node = find_node(src_node)
	
	if typeof(trg_node) == TYPE_STRING:
		trg_node = find_node(trg_node)
	
	if src_node != null and trg_node != null:
		src_node.connect(src_signal, trg_node, trg_func)

func remote_call(src_node, method, arg0 = null, arg1 = null):
	src_node = find_node(src_node)
	
	if src_node and src_node.has_method(method):
		if arg0 and arg1:
			return src_node.call(method, arg0, arg1)
		if arg0:
			return src_node.call(method, arg0)
		
		return src_node.call(method)

func _get_mouse_pos():
	return get_viewport().get_mouse_pos()

func _get_main_node():
	var root = get_tree().get_root()
	return root.get_child( root.get_child_count()-1 )

func _get_view_size():
	return get_tree().get_root().get_visible_rect().size

func get_digits(number):
	var str_number = str(number)
	var digits = []
	
	for i in range(str_number.length()):
		digits.append(str_number[i].to_int())
	
	return digits

func create_explosion(position):
	var new_explosion = explosion.instance()
	new_explosion.position = position
	get_parent().add_child(new_explosion)

func change_scene(scene_name, scene_type):
	call_deferred("_deffered_change_scene", scene_name, scene_type)

func _deffered_change_scene(scene_name, scene_type):
	var path = SCENE_PATH + scene_name + ".tscn"
	
	if scene_type == "stage":
		path = STAGE_PATH + scene_name + ".tscn"
	
	var root = get_tree().get_root()
	var current = root.get_child(root.get_child_count() - 1)
	print(current)
	current.free()
	
	var scene_resource = ResourceLoader.load(path)
	var new_scene = scene_resource.instance()
	
	get_tree().get_root().add_child(new_scene)
	get_tree().set_current_scene(new_scene)
	
