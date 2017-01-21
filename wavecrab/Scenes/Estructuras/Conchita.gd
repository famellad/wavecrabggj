extends KinematicBody2D

var dir = Vector2()
var danno = 1
var velocidad = 800

func _fixed_process(delta):
	var rem = move(delta * dir * velocidad)
	if is_colliding():
		var col = get_collider()
		if col.hit:
			col.hit(self)
		else:
			print("Objeto con mascara de enemigo no tiene evento al ser dannado")

func _ready():
	set_fixed_process(true)