extends Node2D

onready var l1_button = $LevelSelect/HBoxContainer/Level1
onready var l2_button = $LevelSelect/HBoxContainer/Level2
onready var l3_button = $LevelSelect/HBoxContainer/Level3
onready var back_button = $LevelSelect/Back

func _ready():
	SoundManager.specify_level("MainMenu")
	
	l1_button.disabled = true
	l2_button.disabled = true
	l3_button.disabled = true
	
	back_button.grab_focus()

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		SceneTransition.change_scene("res://Levels and Menus/MainMenu.tscn")

func _physics_process(delta):
	if (len(GlobalData.current_data) != 0):
		if (GlobalData.current_data["level1"] == true):
			l1_button.disabled = false
	
		if (GlobalData.current_data["level2"] == true):
			l2_button.disabled = false
	
		if (GlobalData.current_data["level3"] == true):
			l3_button.disabled = false

func _on_Level1_pressed():
	SceneTransition.change_scene("res://Levels and Menus/Level1.tscn")
	SoundManager.play_menu_confirm_sound()

func _on_Level2_pressed():
	SceneTransition.change_scene("res://Levels and Menus/Level2.tscn")
	SoundManager.play_menu_confirm_sound()

func _on_Level3_pressed():
	SceneTransition.change_scene("res://Levels and Menus/Level3.tscn")
	SoundManager.play_menu_confirm_sound()

func _on_Back_pressed():
	SoundManager.play_menu_confirm_sound()
	SceneTransition.change_scene("res://Levels and Menus/MainMenu.tscn")

func _on_Level1_focus_entered():
	SoundManager.play_menu_select_sound()

func _on_Level2_focus_entered():
	SoundManager.play_menu_select_sound()

func _on_Level3_focus_entered():
	SoundManager.play_menu_select_sound()

func _on_Back_focus_entered():
	SoundManager.play_menu_select_sound()
