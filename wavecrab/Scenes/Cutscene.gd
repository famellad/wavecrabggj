extends Node2D

var t = 0

func _ready():
	set_process(true)

func _process(delta):
	t += delta
	
	if Input.is_action_pressed("mouse_down") or t >= 16:
		get_tree().change_scene("res://Scenes/Titulo.tscn")