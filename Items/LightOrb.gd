extends "res://Items/Item.gd"

onready var soulDetector = $SoulDetector
onready var timer = $Timer

export var increment_amt = 1

var is_picked_up = false

signal increase_light_level(increment)

func _ready():
	timer.set_wait_time(2)

func absorb_souls():
	var areas = soulDetector.get_overlapping_areas()
	for area in areas:
		area.set_target(self.get_parent())

func change_is_picked_up():
	is_picked_up = !is_picked_up
	if is_picked_up == true:
		#start timer
		timer.start()
		print("Timer started from picking up orb")
		pass
	else:
		#stop timer
		timer.stop()
		print("Timer stopped after dropping up orb")
		pass

func _physics_process(delta):
	absorb_souls()

func _on_SoulDetector_area_entered(area):
	if area.get_item_type() == "Soul":
		emit_signal("increase_light_level", increment_amt)

func _on_Timer_timeout():
	emit_signal("increase_light_level", increment_amt*5)
