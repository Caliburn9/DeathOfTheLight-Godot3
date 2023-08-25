extends Node2D

onready var continue_button = $MainMenu/VBoxContainer/Continue

func _ready():
	SoundManager.specify_level("MainMenu")
	
	$MainMenu/VBoxContainer/Start.grab_focus()
	get_tree().paused = false
	
	if GlobalData.current_data.size() == 0:
		continue_button.disabled = true
	else:
		if GlobalData.current_data["current_level"] == "":
			continue_button.disabled = true
		else:
			continue_button.disabled = false

func start_new_game():
	SoundManager.play_menu_confirm_sound()
	GlobalData.reset_data()
	GlobalData.sava_data(GlobalData.filePath)
	SceneTransition.change_scene("res://Levels and Menus/Tutorial.tscn")

func _on_Start_pressed():
	#need to add pop up that tells player that this will
	#delete previous save
	if GlobalData.current_data.size() == 0: 
		start_new_game()
	else:
		if GlobalData.current_data["current_level"] == "":
			start_new_game()
		else:
			SoundManager.play_menu_confirm_sound()
			SceneTransition.change_scene("res://Levels and Menus/AreYouSure.tscn")

func _on_Continue_pressed():
	SoundManager.play_menu_confirm_sound()
	SceneTransition.change_scene(GlobalData.current_data["current_level"])

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

func _on_Continue_focus_entered():
	SoundManager.play_menu_select_sound()
