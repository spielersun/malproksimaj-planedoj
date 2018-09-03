extends KinematicBody2D

export(PackedScene) var red_alert
export(PackedScene) var bullet

export var speed = 100

onready var engine = $engine
onready var bus_anims = $bus
onready var beam = $beam

var ascending = false
var descending = false

var limiter = 0
var scorer = 0

var score_text	
var new_score	
var accelerating = false

func _ready():
	score_text = get_tree().get_root().get_node("episode_optimus").find_node("score_label")
	new_score = 0

func _physics_process(delta):
	if accelerating:
		scorer += delta
		if scorer >= 1.01:
			scorer = 0
		new_score = int(score_text.text) + floor(scorer)
	else:
		scorer += delta
		if scorer >= 1.01:
			scorer = 0
		new_score = int(score_text.text) - floor(scorer)
			
	if Input.is_action_just_pressed("fp_forward"):
		engine.play()
		bus_anims.play("move-right")
		accelerating = true
	elif Input.is_action_just_released("fp_forward"):
		engine.stop()
		bus_anims.play("idle")
		accelerating = false
		
	if Input.is_action_pressed("fp_up"):
		accelerating = false
		jump()
	
	if ascending:
		limiter += delta
		position.y -= speed * (limiter/3)
		if position.y <= 700:
			limiter = 0
			ascending = false
			descending = true
	elif descending:
		limiter += delta
		position.y += speed * (limiter/3)
		if position.y >= 750:
			limiter = 0
			ascending = false
			descending = false
			ground()
	score_text.text = str(new_score)
	
	if Input.is_action_just_pressed("fp_transform"):
		shoot()
	
func jump():
	bus_anims.play("jump")
	yield(bus_anims, "animation_finished")
	ascending = true
	
func ground():
	bus_anims.play("ground")
	yield(bus_anims, "animation_finished")

func red_alert():
	var new_alert = red_alert.instance()
	belt.main_node.add_child(new_alert)

func shoot():
	var new_bullet = bullet.instance()
	# print(turret_angle)
	
	var bullet_x = position.x + 120
	var bullet_y = position.y - 135
	
	beam.play()
	
	get_parent().add_child(new_bullet)
	new_bullet.position = Vector2(bullet_x, bullet_y) 