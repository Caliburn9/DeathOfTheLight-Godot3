extends Node2D

func _input(event):
	if event.is_action_pressed("pause"):
		get_tree().change_scene("res://Levels and Menus/Level1.tscn")
		get_tree().paused = false
	
	if event.is_action_pressed("ui_cancel"):
		get_tree().change_scene("res://Levels and Menus/MainMenu.tscn")
		get_tree().paused = false
