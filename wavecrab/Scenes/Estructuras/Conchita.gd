extends KinematicBody2D

onready var _anim = get_node("Conchita/AnimationPlayer")
var dir = Vector2()
export var danno = 1
export var velocidad = 800

func play_spin():
	_anim.play("Spinspin")

func _fixed_process(delta):
	var rem = move(delta * dir * velocidad)
	if is_colliding():
		var col = get_collider()
		if col.has_method("hit"):
			col.hit(self)
		else:
			print("Objeto con mascara de enemigo no tiene evento al ser dannado")

func _ready():
	set_fixed_process(true)
	_anim.connect("finished", self, "play_spin")