extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

const VEL_MAX = 10.0
var velocidad = 0
var aceleracion = 16
var max_contador = -1

var destino = Vector2(0,0)
onready var cangrejo = get_node("Cangrejo")
onready var contador = preload("res://Scenes/UI/Contador.tscn")
var contador_node
var contador_ref
	
func _fixed_process(delta):
	var dir = (destino - cangrejo.get_pos())
	var dist = dir.length()
	dir = dir.normalized()
	
	if velocidad < VEL_MAX:
		var tmp_accel = aceleracion
		var dv = tmp_accel * delta
		if velocidad + dv > VEL_MAX:
			velocidad = VEL_MAX
		else: 
			velocidad += dv
			
	if dist > 30:
		var mot = cangrejo.move(dir * velocidad)
		if mot.length() > 0:
			destino = cangrejo.get_pos()
	else:
		velocidad = 0
		set_fixed_process(false)
		

func _process(delta):
	#Contador
	if max_contador <= 0:
		iniciar_contador()
	else:
		max_contador -= delta
		var tiempo_restante = round(max_contador)
		
		if (contador_ref.get_ref()):
			contador_node.set_value(tiempo_restante)
	
			if tiempo_restante <= 0:
				#Animación final?
				#Instanciar la ola
				contador_node.free()

func _input(event):
	if (event.type == InputEvent.MOUSE_BUTTON and event.pressed and event.button_index == 1):
		destino = get_global_mouse_pos()
		set_fixed_process(true)
		
func iniciar_contador():
	randomize()
	max_contador = floor(rand_range(5, 30))
	contador_node = contador.instance()
	#Corregir posición!
	contador_node.set_pos(Vector2(958.046204, 130.461441))
	get_node("GUI").add_child(contador_node)
	contador_ref = weakref(contador_node)

func _ready():
	set_process(true)
	set_process_input(true)
