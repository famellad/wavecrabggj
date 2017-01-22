extends StaticBody2D

export(int) var health = 18

func hit(en):
	health -= en.danno
	if health <= 0:
		queue_free(self)
	