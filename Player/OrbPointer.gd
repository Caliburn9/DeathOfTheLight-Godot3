extends Node2D

var rotSpd = 100
var tar = null

func _physics_process(delta):
	if tar != null:
		rotate_to_target(tar, delta)

func set_target(val):
	tar = val

func rotate_to_target(target, delta):
	var dir = target.global_position - global_position 
	var angleTo = $Sprite.transform.y.angle_to(-dir)
	$Sprite.rotate(sign(angleTo) * min(delta * rotSpd, abs(angleTo)))
