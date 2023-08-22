extends Area2D

export var dialogue_key = ""
export (float) var dialogue_display_chance = 0
var randomizer = RandomNumberGenerator.new()

func _ready():
	randomizer = RandomNumberGenerator.new()

func _on_DialogueArea_area_entered(area):
	var chance = stepify(randomizer.randf_range(0.1, 1), 0.1)
	if dialogue_display_chance == chance:
		DialogueSignalBus.emit_signal("display_dialogue", dialogue_key)
