extends Node2D

func _ready():
	GlobalData.current_data["current_level"] = get_tree().current_scene.filename
	SoundManager.specify_level("Level")
