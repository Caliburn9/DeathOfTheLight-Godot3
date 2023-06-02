tool
extends Node

var sounds = []
var rng = RandomNumberGenerator.new()

var last_index = 0
var index = 0

func _ready():
	for child in get_children():
		if child.has_method("is_type") && child.is_type("SoundQueue"):
			sounds.append(child)

func play_random_sound():
	if index == last_index:
		index = rng.randi_range(0, sounds.size() - 1)
	
	last_index = index 
	sounds[index].play_sound()

func _get_configuration_warning() -> String:
	var message = ""
	var childNum = 0
	
	for child in get_children():
		if !child.has_method("is_type"):
			message = "Expected only SoundQueues as children."
		else:
			childNum += 1
	
	if childNum < 2:
		message = "Expected two or more children of type SoundQueue."
	
	return message
