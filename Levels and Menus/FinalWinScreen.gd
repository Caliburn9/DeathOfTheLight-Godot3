extends Node2D

func _ready():
	SoundManager.specify_level("MainMenu")
	SoundManager.play_game_win_sound()

func _input(event):
	if event.is_action_pressed("pause"):
		SceneTransition.change_scene("res://Levels and Menus/Level1.tscn")
		get_tree().paused = false
	
	if event.is_action_pressed("ui_cancel"):
		SceneTransition.change_scene("res://Levels and Menus/MainMenu.tscn")
		get_tree().paused = false
