extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

const VEL = 200.0

var inicio = Vector2()
var final = Vector2()
var path = []

func _process(delta):
	if (path.size() > 1):
		var to_walk = delta*VEL
		while(to_walk > 0 and path.size() >= 2):
			var pfrom = path[path.size() - 1]
			var pto = path[path.size() - 2]
			var d = pfrom.distance_to(pto)
			if (d <= to_walk):
				path.remove(path.size() - 1)
				to_walk -= d
			else:
				path[path.size() - 1] = pfrom.linear_interpolate(pto, to_walk/d)
				to_walk = 0
		
		var atpos = path[path.size() - 1]
		get_node("Cangrejo").set_pos(atpos)
		
		if (path.size() < 2):
			path = []
			set_process(false)
	else:
		set_process(false)

func _update_path():
	var p = get_simple_path(inicio, final, true)
	path = Array(p) # Vector2array too complex to use, convert to regular array
	path.invert()
	
	set_process(true)
	
func _input(event):
	if (event.type == InputEvent.MOUSE_BUTTON and event.pressed and event.button_index == 1):
		#inicio = get_node("Cangrejo").get_pos()
		# Mouse to local navigation coordinates
		#final = event.pos - get_pos()
		var mousepoint = get_global_mouse_pos()
		var crab = get_node("Cangrejo")
		var vector = (mousepoint - crab.get_pos()).normalized()
		crab.move(vector * VEL * delta)
		#_update_path()


func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass
