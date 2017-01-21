extends Node2D

export(int, "Top", "Left", "Right") var dir

export(float) var cadencia = 1 / 10
export(int) var grupos = 5
export(int) var enemigos_por_grupo = 4
export(bool) var habilitado = false
export(String, FILE, "*.tscn") var enemigo = "res://Scenes/Enemigos/tortuga.tscn"

var enemigo_tpl = load(enemigo)
var _tiempo_ultimo_spawn = cadencia
var _grupos_spawneados = grupos

const DIR_TOP = 0
const DIR_LEFT = 0
const DIR_RIGHT = 0

func spawnear_oponentes():
	for i in range(0, enemigos_por_grupo):
		var en = enemigo_tpl.instantiate()
		
		var lu = get_pos() - get_scale()
		var rd = get_pos() + get_scale()
		var rx = lu.x + (rd.x - lu.x) * randf()
		var ry = lu.y + (rd.y - lu.y) * randf()
		
		en.set_pos(Vector2(rx, ry))
		add_child(en)
		
	_grupos_spawneados += 1

func _fixed_process(dt):
	if habilitado:
		_tiempo_ultimo_spawn += dt
		if _tiempo_ultimo_spawn > cadencia and\
			_grupos_spawneados < grupos:
			spawnear_oponentes()
			_tiempo_ultimo_spawn -= cadencia

func _ready():
	pass