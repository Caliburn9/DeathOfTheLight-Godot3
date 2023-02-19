extends Area2D

var item = null

func _physics_process(delta):
	var areas = get_overlapping_areas()
	if areas != null:
		item = areas.pop_front()
	
#	if item != null:
#		item.set_shader_width(1)
	
	if areas == null:
		item = null

func item_detected():
	return item != null

func return_item():
	return item

#func _on_ItemDetector_area_entered(area):
#	area.set_shader_width(1)
#
#func _on_ItemDetector_area_exited(area):
#	item.set_shader_width(0)
