extends Area2D

var invul = false setget set_invul

onready var timer = $Timer
onready var collisionShape = $CollisionShape2D

signal invul_start
signal invul_end

#this solution is not needed in this case
#signals can be put where the invul values are changed
#the setget allows invul to be set in cases other than collision
func set_invul(value):
	invul = value
	if invul == true:
		emit_signal("invul_start")
	else:
		emit_signal("invul_end")

func start_invul(duration):
	self.invul = true
	timer.start(duration)

func _on_Timer_timeout():
	self.invul = false

func _on_Hurtbox_invul_start():
	collisionShape.set_deferred("disabled", true)

func _on_Hurtbox_invul_end():
	collisionShape.disabled = false
