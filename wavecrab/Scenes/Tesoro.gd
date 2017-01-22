extends StaticBody2D

var huyendo = false
var n_tortugas = 0
onready var animc = get_node("Cofre/AnimCofre")
onready var animt = get_node("Tartarugas/AnimTart")

func _ready():
	get_node("Tartarugas").set_opacity( 0 )
	set_fixed_process(true)

func _fixed_process(delta):
	if n_tortugas == 1:
		if animc.get_current_animation() != "1tort":
			get_node("Tartarugas").set_opacity( 1 )
			animc.play("1tort")
			animt.play("1tort")
	elif n_tortugas == 2:
		if animc.get_current_animation() != "2tort":
			animc.play("2tort")
			animt.play("2tort")
	elif n_tortugas == 3:
		if animc.get_current_animation() != "huyen2":
			animc.play("huyen2")
			get_node("Tartarugas").set_opacity( 0 )
			huyendo = true
			var old_cam = get_parent().get_node("Cangrejo/Camera2D")
			var new_cam = get_node("Camera2D")
			new_cam.make_current()
			#Problema! Como sólo se mueve la animación, la cámara no sigue al objeto... Cómo se puede arreglar?
			get_node("game_over").show()
			get_node("again").show()
			
			
func add_tartaruga( tartaruga ):
	n_tortugas += 1
	tartaruga.queue_free()

func _on_Goal_body_enter( body ):
	if huyendo:
		return
	
	if body.is_in_group("enemigos"):
		add_tartaruga(body)