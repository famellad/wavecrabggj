extends Node2D

var valor = 0
onready var _label = get_node("Label")

func _ready():
	set_process(true)

func _process(delta):
	_label.set_text(str(valor))