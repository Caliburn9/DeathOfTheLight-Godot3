extends "res://Items/Item.gd"

onready var stasisArea = $StasisArea
onready var timer = $Timer

export(float) var time = .25

func _ready():
	timer.set_wait_time(time)

func stop_enemies():
	stasisArea.show()
	timer.start()

func _on_Timer_timeout():
	stasisArea.hide()
	queue_free()

func _on_StasisArea_body_entered(body):
	if stasisArea.is_visible_in_tree():
		body.set_max_speed(0)
