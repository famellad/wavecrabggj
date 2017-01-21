extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	pass

func start_game():
	get_tree().change_scene( "res://Scenes/Juego.tscn" )