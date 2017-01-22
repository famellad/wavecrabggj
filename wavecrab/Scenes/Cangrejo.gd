extends KinematicBody2D

var prev_pos = Vector2()
var moving = false
onready var anim = get_node("Sprite/AnimationPlayer")
onready var recursos = load("res://Scenes/UI/ContadorRecursos.tscn")
var recursos_node
const COSTO_TORRE = 10
const COSTO_CASTILLO = 100
const LARGO_TORRE = 230
const LARGO_CASTILLO = 500
const RADIO_CANGREJO = 76.5

var wait = 0

func _ready():
	get_node("Camera2D").make_current()
	set_process(true)
	recursos_node = recursos.instance()
	recursos_node.hide()
	#Corregir posición!
	#recursos_node.set_pos(Vector2(958.046204, 130.461441))
	add_child(recursos_node)
	
	
func _process( delta ):
	if prev_pos == get_pos():
		moving = false
		
		if anim.get_current_animation() != "idle" and wait >= 1/15:
			anim.play("idle")
			wait = 0
			return
		
		wait += delta
	else:
		moving = true
		if anim.get_current_animation() != "walk":
			anim.play("walk")
		
	prev_pos = get_pos()
	
func construir_torre():
	var valor_actual = int(recursos_node.get_label())
	if valor_actual >= COSTO_TORRE:
		#Construir torre, descontar recursos.
		var torre = load("res://Scenes/Estructuras/Torre.tscn")
		var torre_node = torre.instance()
		var new_pos = Vector2(get_pos().x - (LARGO_TORRE/2 + RADIO_CANGREJO))
		torre_node.set_pos(new_pos)
		get_parent().add_child(torre_node)
		recursos_node.set_label(str(valor_actual - COSTO_TORRE))
	else:
		#Alerta?
		print("No tiene suficientes recursos")
		
func construir_castillo():
	var valor_actual = int(recursos_node.get_label())
	if valor_actual >= COSTO_CASTILLO:
		#Construir castillo, descontar recursos.
		var castillo = load("res://Scenes/Estructuras/Castillo.tscn")
		var castillo_node = castillo.instance()
		var new_pos = Vector2(get_pos().x - (LARGO_CASTILLO/2 + RADIO_CANGREJO))
		castillo_node.set_pos(new_pos)
		castillo_node.set_pos(get_pos())
		get_parent().add_child(castillo_node)
		recursos_node.set_label(str(valor_actual - COSTO_CASTILLO))
	else:
		#Alerta?
		print("No tiene suficientes recursos")

func _on_construir_torre_released():
	construir_torre()


func _on_construir_castillo_released():
	construir_castillo()
