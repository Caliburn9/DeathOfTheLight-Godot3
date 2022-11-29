extends Area2D

func _on_Pedestal_body_entered(body):
	body.is_near_pedestal(true)
