tool
extends Node

export(int) var count = 1

var audioStreamPlayers = []
var next = 0
var child

func is_type(type): 
	return type == "SoundQueue" or .is_type(type)
	
func get_type(): 
	return "SoundQueue"

func _ready():
	child = get_child(0)
	
	if child is AudioStreamPlayer:
		audioStreamPlayers.append(child)
		
		for i in count - 1:
			var duplicate = child.duplicate(i)
			add_child(duplicate)
			audioStreamPlayers.append(duplicate)

func play_sound():
	if !audioStreamPlayers[next].playing:
		next += 1
		if next >= audioStreamPlayers.size():
			next %= audioStreamPlayers.size()
		audioStreamPlayers[next].play()

func stop_sound():
	var curr = next - 1
	if audioStreamPlayers[curr].playing:
		audioStreamPlayers[curr].playing = false

func _get_configuration_warning() -> String:
	if get_child_count() == 0:
		return "No children found. Expected one AudioStreamPlayer child."
	
	if child is AudioStreamPlayer:
		return "Expected first child to be an AudioStreamPlayer."
	
	return ""
