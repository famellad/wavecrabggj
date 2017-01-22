extends Node2D

const VEL_MAX = 10.0
var velocidad = 0
var aceleracion = 16
var max_contador = -1
var estado = "valle" # Estados son valle y combate

var sticks = 0

var destino = Vector2(0,0)
onready var cangrejo = get_node("Cangrejo")
onready var contador = preload("res://Scenes/UI/Contador.tscn")
var contador_node
var contador_ref
onready var _ola_lbl = get_node("GUI/ola")

const t_ola = 45

var ola = 0
onready var spawners = get_tree().get_nodes_in_group("spawner")
onready var spawn_strategy = get_node("SpawnStrategy")

func _fixed_process(delta):
	if Input.is_action_pressed("mouse_down"):
		destino = get_global_mouse_pos()
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
				var n = cangrejo.get_collision_normal()
				dir = n.slide(dir)
				cangrejo.move(dir * velocidad)
		else:
			velocidad = 0
		

func iniciar_ola():
	ola += 1
	
	_ola_lbl.set_text("Ola: " + str(ola))
	
	if ola == 1:
		return
	
	spawn_strategy.iniciar_ola(ola, t_ola)
	for spawn in spawners:
		spawn_strategy.aplicar_spawn(spawn)

func _process(delta):
	#Contador
	if max_contador <= 0:
		iniciar_ola()
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
		
func iniciar_contador():
	randomize()
	max_contador = t_ola
	contador_node = contador.instance()
	#Corregir posición!
	contador_node.set_pos(Vector2(958.046204, 130.461441))
	get_node("GUI").add_child(contador_node)
	contador_ref = weakref(contador_node)

func _ready():
	set_process(true)
	set_process_input(true)
	set_fixed_process(true)


func _on_again_released():
	get_tree().reload_current_scene()
