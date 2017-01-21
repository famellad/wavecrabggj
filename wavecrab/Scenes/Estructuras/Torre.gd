extends Node2D

export var cooldown = 1
export var max_range = 500
var target = null

func _ready():
	pass

func set_target( new_target ):
	target = new_target

func atacar():
	if target == null:
		pass
		
	if target.get_pos().distance_squared( get_pos() ) > 500 * 500:
		# target esta fuera de rango, es hora de encontrar un nuevo objetivo
		pass
	
	else:
		# dothething
		pass

