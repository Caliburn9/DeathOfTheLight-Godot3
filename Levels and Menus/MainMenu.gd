extends Node2D

func _ready():
	SoundManager.specify_level("MainMenu")
	
	$MainMenu/VBoxContainer/Start.grab_focus()
	get_tree().paused = false

func _on_Start_pressed():
	#need to add pop up that tells player that this will
	#delete previous save
	SoundManager.play_menu_confirm_sound()
	GlobalData.reset_data()
	GlobalData.sava_data(GlobalData.filePath)
	SceneTransition.change_scene("res://Levels and Menus/Level1.tscn")

func _on_Level_Select_pressed():
	SoundManager.play_menu_confirm_sound()
	GlobalData.load_data(GlobalData.filePath)
	SceneTransition.change_scene("res://Levels and Menus/LevelSelect.tscn")

func _on_Quit_pressed():
	SoundManager.play_menu_confirm_sound()
	get_tree().quit()

func _on_Start_focus_entered():
	SoundManager.play_menu_select_sound()

func _on_Level_Select_focus_entered():
	SoundManager.play_menu_select_sound()

func _on_Quit_focus_entered():
	SoundManager.play_menu_select_sound()
