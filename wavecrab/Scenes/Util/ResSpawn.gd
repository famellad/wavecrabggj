extends Node2D

# Variable palito
var palito = null
onready var palitos = get_node("Palitos")
onready var sa = get_node("SpawnArea")

const countdown_t = 1.5
var countdown = countdown_t

func _ready():
	palito = load("res://Scenes/Stick.tscn")
	set_process(true)

func _process(delta):
	pass
	countdown -= delta
	if countdown < 0:
		countdown = countdown_t
		spawn_palito()

func random_point():
	var x = randf() * 1024 * sa.get_scale().x + sa.get_global_pos().x
	var y = randf() * 1024 * sa.get_scale().y + sa.get_global_pos().y
	
	return Vector2(x, y)
	
func spawn_n_palitos( n ):
	for i in range(n):
		spawn_palito()
	
func spawn_palito():
	#spawnear palito
	var nov_palito = palito.instance()

	# donde esta?
	nov_palito.set_pos( random_point() )
	nov_palito.set_scale( Vector2(1, 1) )
	
	# su angulio
	nov_palito.get_node("Colision/Ramita").rotate( randf() * 6 )
	
	# y que se mueva
	nov_palito.get_node("Colision/Anim").play("DesdeMar")
	
	# agregar al grupo
	palitos.add_child(nov_palito)