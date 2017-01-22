extends KinematicBody2D

var target
var _t_restante_ataque = 0
var huyendo = false

var unboost = 0

export var danno = 2
export var _health = 7
export var cadencia = 0.8
export var velocidad = 1
export var boost = 300

func hit(part):
	_health -= part.danno
	if _health <= 0:
		huir()
		
func crab_hit():
	_health -= 2
	if _health <= 0:
		huir()

func encontrar_target():
	if huyendo:
		var spawner = get_tree().get_nodes_in_group("spawner")
		for s in spawner:
			target = weakref(s)
		velocidad = 300
		return
	
	var pot_targets = get_tree().get_nodes_in_group("fuente")
	for x in pot_targets:
		target = weakref(x) 
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
	unboost += delta * 10
	unboost = min(unboost, boost)
	
	if get_pos().y >= 3000:
		self.queue_free()
	
	_t_restante_ataque -= delta
	
	if not self:
		return

	if target == null:
		return
	
	if not target.get_ref():
		encontrar_target()
				
	if target.get_ref():
		var movdir = (target.get_ref().get_global_pos() - get_global_pos()).normalized()
		var resto = move(movdir * (velocidad + boost - unboost) * delta)
		if resto.length_squared() > 0:
			if is_colliding():
				en_colision(get_collider())
				

func en_colision(en):
	if en.has_method("hit") and _t_restante_ataque < 0:
		en.hit(self)
		_t_restante_ataque  = cadencia

func huir():
	get_node("CollisionShape2D").set_trigger(true)
	get_node("piratewalk/AnimationPlayer").play("flee")
	huyendo = true
	encontrar_target()

func _ready():
	set_fixed_process(true)
	encontrar_target()