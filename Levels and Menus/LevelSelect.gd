extends Node2D

onready var l1_button = $LevelSelect/HBoxContainer/Level1
onready var l2_button = $LevelSelect/HBoxContainer/Level2
onready var l3_button = $LevelSelect/HBoxContainer/Level3

func _ready():
	l1_button.disabled = true
	l2_button.disabled = true
	l3_button.disabled = true
	
	l1_button.grab_focus()

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().change_scene("res://Levels and Menus/MainMenu.tscn")

func _physics_process(delta):
	if (len(GlobalData.current_data) != 0):
		if (GlobalData.current_data["level1"] == true):
			l1_button.disabled = false
	
		if (GlobalData.current_data["level2"] == true):
			l1_button.disabled = false
	
		if (GlobalData.current_data["level3"] == true):
			l1_button.disabled = false

func _on_Level1_pressed():
	get_tree().change_scene("res://Levels and Menus/Level1.tscn")

func _on_Level2_pressed():
	get_tree().change_scene("res://Levels and Menus/Level2.tscn")

func _on_Level3_pressed():
	get_tree().change_scene("res://Levels and Menus/Level3.tscn")

func _on_Reset_pressed():
	GlobalData.reset_data()
	GlobalData.sava_data(GlobalData.filePath)
	get_tree().reload_current_scene()
