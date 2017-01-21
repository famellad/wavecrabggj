extends Node2D

var dir = Vector2()
var concha = preload("res://Scenes/Estructuras/Conchita.tscn")
export var cadencia = 1 / 2
export(float) var cono = 2 * PI
export(float) var radio = 100
export(bool) var unico_objetivo = false
var t_ultimo_disparo = cadencia


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
		fuego((en.get_pos() - get_pos()).normalized())
	return unico_objetivo
	
func fuego(dir):
	var cn = concha.instance()
	cn.set_pos(get_pos())
	cn.dir = dir
	add_child(cn)
	
## func _input(event):
##	if (event.type == InputEvent.MOUSE_BUTTON 
##		and event.pressed 
##		and event.button_index == 1):
##			fuego( (get_local_mouse_pos() - get_pos()).normalized() )
	
func _ready():
	var textura = floor(randf() * 2.999)
	Texture = "res://Gfx/Estructuras/Castillo" + str(textura) + ".png"
	_update()
	
	set_fixed_process(true)
	# set_process_input(true)