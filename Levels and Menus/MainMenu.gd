extends Node2D

onready var start = $MainMenu/VBoxContainer/Start
onready var quit = $MainMenu/VBoxContainer/Quit

func _ready():
	start.grab_focus()

func _on_Start_pressed():
	get_tree().change_scene("res://Levels and Menus/Level1.tscn")

func _on_Quit_pressed():
	get_tree().quit()
