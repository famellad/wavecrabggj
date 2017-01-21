extends KinematicBody2D

var prev_pos = Vector2()
var moving = false
onready var anim = get_node("Sprite/AnimationPlayer")

func _ready():
	get_node("Camera2D").make_current()
	set_process(true)
	
func _process( delta ):
	if prev_pos == get_pos():
		moving = false
		if anim.get_current_animation() != "idle":
			anim.play("idle")
	else:
		moving = true
		if anim.get_current_animation() != "walk":
			anim.play("walk")
		
	prev_pos = get_pos()