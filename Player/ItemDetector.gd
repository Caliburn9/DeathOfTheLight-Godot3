extends Area2D

var item = null

func _physics_process(delta):
	var areas = get_overlapping_areas()
	if areas != null:
		item = areas.pop_front()
	
	if areas == null:
		item = null

func item_detected():
	return item != null

func return_item():
	return item
