extends KinematicBody2D

onready var _anim = get_node("Conchita/AnimationPlayer")
var dir = Vector2()
export var danno = 2
export var velocidad = 800

var boom = false

func play_spin():
	_anim.play("Spinspin")

func _fixed_process(delta):
	if boom: return
	
	var rem = move(delta * dir * velocidad)
	if is_colliding():
		var col = get_collider()
		if col.has_method("hit"):
			col.hit(self)
		#else:
		#	print("Objeto con mascara de enemigo no tiene evento al ser dannado")
		explode()
		
func mprint():
	queue_free()
	
func explode():
	dir = Vector2()
	_anim.play("kapow")
	boom = true
	set_collision_mask(0)
	
		
func _ready():
	set_fixed_process(true)
	_anim.animation_set_next("Spawn", "Spinspin")
	_anim.play("Spawn")
	_anim.connect("finished", self, "mprint")