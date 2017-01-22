extends Node2D

onready var _label = get_node("Label")
onready var _anim = get_node("Label/Anim")
var valor setget set_label, get_label

func set_label(s):
	var val = int(s)
	
	if val < int(_label.get_text()):
		_anim.play("Dec")
	else:
		_anim.play("Inc")
		
	_label.set_text(s)
	
func get_label():
	return _label.get_text()