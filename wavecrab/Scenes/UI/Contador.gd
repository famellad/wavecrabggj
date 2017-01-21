extends Node2D

var valor = 0

onready var _label = get_node("Label")
onready var _anim = get_node("pentagono/Anim")
func _ready():
	set_process(true)


		
func set_value(val):
	if (str(val) != _label.get_text()):
		_anim.play("BumpTime")
	
	_label.set_text(str(val))