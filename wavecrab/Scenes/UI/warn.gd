extends Node2D

var dir_flecha = Vector2(0, 0)
onready var flecha = get_node("flecha")
onready var dist_flecha = flecha.get_pos().length()

func _ready():
	set_process(true)

func _process(delta):
	dir_flecha = (get_local_mouse_pos() - get_pos()).normalized()
	flecha.set_pos(dir_flecha * dist_flecha)
	flecha.set_rot(-atan2(dir_flecha.x, -dir_flecha.y))