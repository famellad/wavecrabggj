extends KinematicBody2D

var inicio = Vector2()
var final = Vector2()
var path = []

func _ready():
	set_process_input( true )

func _update_path():
	get_parent().get_node("Navegador")
	
	
	set_process(true)