extends AnimatedSprite

func _ready():
	#self (1st) - object that has the signal, usually in the tree
	#connect - make connection to signal function
	#signal name
	#where to connect
	#function to connect signal to
	self.connect("animation_finished", self, "_on_animation_finished")
	frame = 0
	play("Animate")

func _on_animation_finished():
	queue_free()

