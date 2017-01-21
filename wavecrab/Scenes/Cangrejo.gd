extends KinematicBody2D

func _ready():
	get_node("Camera2D").make_current()
	set_process(true)
	
func _process( delta ):
	pass