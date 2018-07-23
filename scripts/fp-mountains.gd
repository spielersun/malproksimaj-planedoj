extends Node

const MOVE_SPEED_1 = 100
const MOVE_SPEED_2 = 75
const MOVE_SPEED_3 = 50
const MOVE_SPEED_4 = 25

const OFFSET = 100

onready var primus = $primus
onready var primus_alium = $primusalium
onready var primus_cauda = $primuscauda

onready var secundus = $secundus
onready var secundus_alium = $secundusalium
onready var secundus_cauda = $secunduscauda

onready var tertius = $tertius
onready var tertius_alium = $tertiusalium
onready var tertius_cauda = $tertiuscauda

onready var quartus = $quartus
onready var quartus_alium = $quartusalium
onready var quartus_cauda = $quartuscauda

var frons_pos
var tergum_pos

func _ready():
	frons_pos = primus.position.x
	tergum_pos = get_viewport_rect().size.x

func _process(delta):
	if Input.is_action_pressed("fp_forward"):
		mountains_move(delta)
	

func mountains_move(delta):
	primus.position.x -= MOVE_SPEED_1 * delta
	primus_alium.position.x -= MOVE_SPEED_1 * delta
	primus_cauda.position.x -= MOVE_SPEED_1 * delta
	
	secundus.position.x -= MOVE_SPEED_2 * delta
	secundus_alium.position.x -= MOVE_SPEED_2 * delta
	secundus_cauda.position.x -= MOVE_SPEED_2 * delta
	
	tertius.position.x -= MOVE_SPEED_3 * delta
	tertius_alium.position.x -= MOVE_SPEED_3 * delta
	tertius_cauda.position.x -= MOVE_SPEED_3 * delta
	
	quartus.position.x -= MOVE_SPEED_4 * delta
	quartus_alium.position.x -= MOVE_SPEED_4 * delta
	quartus_cauda.position.x -= MOVE_SPEED_4 * delta
	
	if primus.position.x <=  -frons_pos :
		primus.position.x = tergum_pos + frons_pos - 2
	elif primus_alium.position.x <= -frons_pos:
		primus_alium.position.x = tergum_pos + frons_pos - 2
	elif primus_cauda.position.x <= -frons_pos:
		primus_cauda.position.x = tergum_pos + frons_pos - 2
	
	if secundus.position.x <=  -frons_pos :
		secundus.position.x = tergum_pos + frons_pos - 1
	elif secundus_alium.position.x <= -frons_pos:
		secundus_alium.position.x = tergum_pos + frons_pos - 1
	elif secundus_cauda.position.x <= -frons_pos:
		secundus_cauda.position.x = tergum_pos + frons_pos - 1
	
	if tertius.position.x <=  -frons_pos :
		tertius.position.x = tergum_pos + frons_pos - 1
	elif tertius_alium.position.x <= -frons_pos:
		tertius_alium.position.x = tergum_pos + frons_pos - 1
	elif tertius_cauda.position.x <= -frons_pos:
		tertius_cauda.position.x = tergum_pos + frons_pos - 1
	
	if quartus.position.x <=  -frons_pos :
		quartus.position.x = tergum_pos + frons_pos - 1
	elif quartus_alium.position.x <= -frons_pos:
		quartus_alium.position.x = tergum_pos + frons_pos - 1
	elif quartus_cauda.position.x <= -frons_pos:
		quartus_cauda.position.x = tergum_pos + frons_pos - 1
	