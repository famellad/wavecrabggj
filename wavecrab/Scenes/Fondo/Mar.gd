extends Node2D

const DISPLACE = 40
const OFFSET = 0.4
const SPEED = 1.2

var t = 0
onready var Ola1 = get_node("Ola1/Ola1")
onready var Ola2 = get_node("Ola2/Ola2")
onready var Ola3 = get_node("Ola3/Ola3")
onready var Ola4 = get_node("Ola4/Ola4")
onready var Burb = get_node("Burbujas")
onready var Harina = get_node("Moja2/harina mojada")

func _ready():
	Harina.set_pos( Vector2( 0, -DISPLACE + 100 ) )
	set_process(true)

func _process(delta):
	var periodo = -(t * SPEED + PI/2) / (2*PI)
	Harina.set_opacity( (periodo - floor(periodo)) * 0.3 )
	var v1 = Vector2( 0, sin(SPEED * t + 3*OFFSET) * DISPLACE )
	Burb.set_pos( v1 )
	Ola4.set_pos( Vector2( 0, sin(SPEED * t) * DISPLACE ) )
	Ola3.set_pos( Vector2( 0, sin(SPEED * t + OFFSET) * DISPLACE ) )
	Ola2.set_pos( Vector2( 0, sin(SPEED * t + 2*OFFSET) * DISPLACE ) )
	Ola1.set_pos( v1 )
	t += delta