extends Node

var spawns = []

export var cadencia_sub_ola = 1
export var enemigos_ola_base = 8
export var enemigos_ola_crecimiento = 2.3
export var sub_olas = 3

var subola_actual = 1
var restantes = 0
var _t_restante_subola = 0
var pend = 0

var activado = false

func _ready():
	set_process(true)

func iniciar_ola(ola, duracion):
	spawns = []
	
	activado = true
	cadencia_sub_ola = duracion / sub_olas
	restantes = enemigos_ola_base + ola * enemigos_ola_crecimiento
	pend = -2 * (restantes - enemigos_ola_base) / (sub_olas * (sub_olas + 1))
	subola_actual = 1
	
func aplicar_spawn(spawn):
	spawns.append(spawn)
	spawn.habilitado = false
	
	
func _process(delta):
	if not activado:
		return
	
	_t_restante_subola -= delta
	if _t_restante_subola < 0:
		_t_restante_subola += cadencia_sub_ola
		
		var total_subola = ceil(pend * subola_actual + enemigos_ola_base / sub_olas)
		print (total_subola)
		for i in range(0, total_subola):
			spawns[0].spawn()
	
		subola_actual += 1