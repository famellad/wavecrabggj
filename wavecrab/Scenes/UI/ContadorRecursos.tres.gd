extends Node2D

onready var _label = get_node("Label")
var valor setget set_label, get_label

func set_label(s):
	_label.set_text(s)
	
func get_label():
	return _label.get_tex()