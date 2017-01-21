extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

const VEL_MAX = 10.0
var velocidad = 0
var aceleracion = 16

var destino = Vector2(0,0)
onready var cangrejo = get_node("Cangrejo")
	
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
	
func _input(event):
	if (event.type == InputEvent.MOUSE_BUTTON and event.pressed and event.button_index == 1):
		destino = get_global_mouse_pos()
		set_fixed_process(true)

func _ready():
	set_process_input(true)