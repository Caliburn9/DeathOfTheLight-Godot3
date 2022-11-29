extends "res://Items/Item.gd"

export var ABSORB_RANGE = 4;

var target = null

func set_target(value):
	target = value

func attract_to_orb():
	if target != null:
		var distance = target.position - position
		position += distance / 10
		if global_position.distance_to(target.global_position) <= ABSORB_RANGE:
			queue_free()
			print("Soul Absorbed")

func _physics_process(delta):
	attract_to_orb()

