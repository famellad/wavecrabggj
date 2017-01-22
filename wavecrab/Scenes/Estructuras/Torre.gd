extends Node2D

var dir = Vector2()
var concha = preload("res://Scenes/Estructuras/Conchita.tscn")
export var cadencia = 2.5
export(float) var cono = 2 * PI
export(float) var radio = 1200
export(bool) var unico_objetivo = false
export(int) var health = 20

var t_ultimo_disparo = cadencia

onready var _anim = get_node("torre/anim")

func die():
	queue_free()

func hit(en):
	health -= en.danno
	if health <= 0:
		_anim.connect("finished", self, "die")
		_anim.play("rip")

func _fixed_process(delta):
	t_ultimo_disparo += delta
	
	var enemigos = get_tree().get_nodes_in_group("enemigos")
	for en in enemigos:
		var dist = (en.get_pos() - get_pos()).length()
		if dist < radio:
			var angle = dir.angle_to(en.get_pos())
			if angle < cono:
				if en_rango(en):
					break
				
	
func en_rango(en):
	if t_ultimo_disparo > cadencia:
		t_ultimo_disparo -= cadencia
		fuego((en.get_global_pos() - get_global_pos()).normalized())
	return unico_objetivo
	
func fuego(dir):
	var cn = concha.instance()
	cn.set_pos(get_global_pos())
	cn.dir = dir
	
	_anim.play("shoot")
	get_parent().add_child(cn)
	
func _input(event):
	if (event.type == InputEvent.MOUSE_BUTTON 
		and event.pressed 
		and event.button_index == 1):
			fuego( (get_local_mouse_pos() - get_pos()).normalized() )
	
func _ready():
	set_fixed_process(true)
	#set_process_input(true)