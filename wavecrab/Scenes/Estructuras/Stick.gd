extends Area2D

export var valor = 5

onready var recursos = get_tree().get_root().get_node("Juego/GUI/contador_recursos")
	
func _on_Stick_body_enter( body ):
	
	if body.get_name() == "Cangrejo":
		var val_nuevo = int(recursos.get_label()) + valor
		recursos.set_label(str(val_nuevo))
		queue_free()