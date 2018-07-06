extends KinematicBody2D

export (float) var rotation_speed = 2
export var speed = 100

export(PackedScene) var bullet
export(PackedScene) var shield

onready var engine = $engine
onready var turret = $turret
onready var ship_anims = $ship
onready var beam = $beam

var accelerated = false
var armor = 5 setget took_hit

signal armor_changed

func _ready():
	pass
	
func _process(delta):
	if Input.is_action_just_pressed("ui_right"):
		engine.play()
		if accelerated:
			ship_anims.play("move-right")
		else:
			ship_anims.play("start-right")
	elif Input.is_action_just_released("ui_right"):
		engine_stop()
	
	if Input.is_action_just_pressed("shoot"):
		shoot()

func _physics_process(delta):
	if Input.is_action_pressed("turret_down"):
		turret.rotation += rotation_speed * delta
	elif Input.is_action_pressed("turret_up"):
		turret.rotation -= rotation_speed * delta
	
	if Input.is_action_pressed("ui_down"):
		position.y += speed * delta
	elif Input.is_action_pressed("ui_up"):
		position.y -= speed * delta
 
func shoot():
	var new_bullet = bullet.instance()
	var turret_angle = turret.rotation
	
	var bullet_x = (position.x + 10) + (40 * cos(turret_angle))
	var bullet_y = (position.y + 20) + (40 * sin(turret_angle))
	
	beam.play()
	
	get_parent().add_child(new_bullet)
	new_bullet.angle = turret_angle
	new_bullet.position = Vector2(bullet_x, bullet_y) 

func engine_stop():
	engine.stop()
	accelerated = false
	ship_anims.play("idle")

func took_hit(new_value):
	hit_shield()
	
	if new_value > 4:
		return
		
	if new_value < armor:
		pass
		
	armor = new_value
	emit_signal("armor_changed", [armor])
		
	if armor <= 0:
		queue_free()
	
func hit_shield():
	var new_hit = shield.instance()
	new_hit.position = position
	get_parent().add_child(new_hit)
	
	
	
	
	
	
	