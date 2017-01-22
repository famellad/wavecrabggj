extends Node

func _ready():
	set_process(true)

func start_game():
	get_tree().change_scene( "res://Scenes/Juego.tscn" )

func _on_Button_released():
	# esto nop hace nadap :)
	pass

func _on_Button_pressed():
	start_game()
	print("estoy aca")
