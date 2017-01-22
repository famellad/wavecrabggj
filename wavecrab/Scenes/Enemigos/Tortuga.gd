extends KinematicBody2D

var danno = 2
var _health = 2
var target
var _t_restante_ataque = 0

export var cadencia = 0.8
export var velocidad = 30

func hit(part):
	_health -= part.danno
	if _health <= 0:
		self.queue_free()

func encontrar_target():
	var pot_targets = get_tree().get_nodes_in_group("fuente")
	for x in pot_targets:
		target = weak_ref(x) 
		return
	
	pot_targets = get_tree().get_nodes_in_group("estructuras")
	var min_dst = 10000000000
	for x in pot_targets:
		var dst = (x.get_global_pos() - get_global_pos()).length()
		if min_dst > dst:
			min_dst = dst
			target = weakref(x)
	
	# Fin target
	
func _fixed_process(delta):
	_t_restante_ataque -= delta
	
	if not self:
		return

	if target == null:
		return
	
	if not target.get_ref():
		encontrar_target()
				
	if target.get_ref():
		
		var movdir = (target.get_ref().get_global_pos() - get_global_pos()).normalized()
		var resto = move(movdir * velocidad * delta)
		if resto.length_squared() > 0:
			if is_colliding():
				en_colision(get_collider())
				

func en_colision(en):
	if en.has_method("hit") and _t_restante_ataque < 0:
		en.hit(self)
		_t_restante_ataque  = cadencia

func _ready():
	set_fixed_process(true)
	encontrar_target()