extends KinematicBody2D

var _health = 2

func hit(part):
	_health -= part.danno
	if _health <= 0:
		self.queue_free()