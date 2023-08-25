extends Node2D

func _ready():
	$AreYouSure/HBoxContainer/Yes.grab_focus()

func _on_Yes_pressed():
	SoundManager.play_menu_confirm_sound()
	GlobalData.reset_data()
	GlobalData.sava_data(GlobalData.filePath)
	SceneTransition.change_scene("res://Levels and Menus/Tutorial.tscn")

func _on_No_pressed():
	SoundManager.play_menu_confirm_sound()
	SceneTransition.change_scene("res://Levels and Menus/MainMenu.tscn")

func _on_Yes_focus_entered():
	SoundManager.play_menu_select_sound()

func _on_No_focus_entered():
	SoundManager.play_menu_select_sound()
