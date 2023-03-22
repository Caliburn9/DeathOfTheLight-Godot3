extends Node2D

func _ready():
	$MainMenu/VBoxContainer/Start.grab_focus()

func _on_Start_pressed():
	#need to add pop up that tells player that this will
	#delete previous save
	GlobalData.reset_data()
	GlobalData.sava_data(GlobalData.filePath)
	get_tree().change_scene("res://Levels and Menus/Level1.tscn")

func _on_Level_Select_pressed():
	GlobalData.load_data(GlobalData.filePath)
	get_tree().change_scene("res://Levels and Menus/LevelSelect.tscn")

func _on_Quit_pressed():
	get_tree().quit()
